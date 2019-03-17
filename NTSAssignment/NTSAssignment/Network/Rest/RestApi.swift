//
//  Network.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol RestApi {
    func execute(request: Request, completion: @escaping (Response)->Void)
}

final class RestApiImpl: RestApi {

    let session: URLSessionInterface

    init(session: URLSessionInterface) {
        self.session = session
    }
    
    func execute(request: Request, completion: @escaping (Response) -> Void) {
        let httpRequest = URLRequestBuilder(request: request).build()
        let task = session.dataTask(with: httpRequest) { (data, response, error) in
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                completion(Response(request: request, statusCode: code, error: error))
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(Response(request: request, statusCode: code, body: json, error: error))
                } catch {
                    completion(Response(request: request, statusCode: code, error: ResponseError.unknown))
                }
            } else {
                completion(Response(request: request, statusCode: code, error: error))
            }
        }
        task.resume()
    }

}

protocol URLSessionInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionInterface { }
