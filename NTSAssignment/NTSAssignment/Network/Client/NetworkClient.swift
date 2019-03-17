//
//  NetworkClient.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol NetworkClient {
    func request<Params, DTO, Model>(endpoint: Endpoint,
                                     params: Params,
                                     mapOutput: @escaping (DTO) throws -> Model,
                                     completion: @escaping (Result<Model>) -> Void) where Params: Encodable, DTO: Decodable
}

struct NetworkClientBuilder {

    func build() -> NetworkClient {
        let serializer = JsonSerializer()
        let responseInterceptors = [StatusCodeCheckInterceptor()]
        let api = RestApiImpl(session: URLSession.shared)

        return NetworkClientImpl(
            api: api,
            responseInterceptors: responseInterceptors,
            serializer: serializer
        )
    }

}

final class NetworkClientImpl: NetworkClient {

    let api: RestApi
    let responseInterceptors: [ResponseInterceptor]
    let serializer: Serializer

    init(api: RestApi, responseInterceptors: [ResponseInterceptor], serializer: Serializer) {
        self.api = api
        self.responseInterceptors = responseInterceptors
        self.serializer = serializer
    }

    func request<Params, DTO, Model>(endpoint: Endpoint,
                                     params: Params,
                                     mapOutput: @escaping (DTO) throws -> Model,
                                     completion: @escaping (Result<Model>) -> Void) where Params : Encodable, DTO : Decodable {
        var req = Request(url: endpoint.url, method: endpoint.method)
        print("request method: \(endpoint.method) url: \(endpoint.url)")

        do {
            req.body = try params.dictionary()
        } catch {
            completion(.failure(error))
        }

        api.execute(request: req) { [weak self] response in
            guard let sSelf = self else { return }
            do {
                let finalResponse = try sSelf.responseInterceptors.reduce(response, { (result, interceptor) -> Response in
                    var ir = interceptor
                    return try ir.intercept(response: result)
                })
                let networkEntity: DTO = try sSelf.serializer.map(response: finalResponse)
                let model: Model = try mapOutput(networkEntity)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
