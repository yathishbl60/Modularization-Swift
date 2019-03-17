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
    let dispatcher: Dispatcher

    init(api: RestApi, responseInterceptors: [ResponseInterceptor],
         serializer: Serializer, dispatcher: Dispatcher = DispatchQueue.main) {
        self.api = api
        self.responseInterceptors = responseInterceptors
        self.serializer = serializer
        self.dispatcher = dispatcher
    }

    func request<Params, DTO, Model>(endpoint: Endpoint,
                                     params: Params,
                                     mapOutput: @escaping (DTO) throws -> Model,
                                     completion: @escaping (Result<Model>) -> Void) where Params : Encodable, DTO : Decodable {
        // Intercept request
        var req = RestRequest(url: endpoint.url, method: endpoint.method)
        do {
            req.body = try params.dictionary()
        } catch {
            dispatcher.dispacthAsync {
                completion(.failure(error))
            }
        }

        // Execute
        api.execute(request: req) { [weak self] response in
            guard let sSelf = self else { return }

            // Intercept response
            do {
                let finalResponse = try sSelf.responseInterceptors.reduce(response, { (result, interceptor) -> RestResponse in
                    var ir = interceptor
                    return try ir.intercept(response: result)
                })

                // Map response to DTO
                let networkEntity: DTO = try sSelf.serializer.map(response: finalResponse)

                // Map DTO to domain model
                let model: Model = try mapOutput(networkEntity)

                // Send model
                sSelf.dispatcher.dispacthAsync {
                    completion(.success(model))
                }
            } catch {
                sSelf.dispatcher.dispacthAsync {
                    completion(.failure(error))
                }
            }
        }
    }

}
