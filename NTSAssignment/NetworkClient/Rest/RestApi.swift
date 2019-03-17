//
//  Network.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol RestApi {
    func execute(request: RestRequest, completion: @escaping (RestResponse)->Void)
}

final class RestApiImpl: RestApi {

    let session: URLSessionInterface

    init(session: URLSessionInterface) {
        self.session = session
    }
    
    func execute(request: RestRequest, completion: @escaping (RestResponse) -> Void) {
        let httpRequest = RestURLRequestBuilder(request: request).build()
        let task = session.dataTask(with: httpRequest) { (data, response, error) in
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let error = error {
                completion(RestResponse(request: request, statusCode: code, error: error))
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(RestResponse(request: request, statusCode: code, body: json, error: error))
                } catch {
                    completion(RestResponse(request: request, statusCode: code, error: ResponseError.unknown))
                }
            } else {
                completion(RestResponse(request: request, statusCode: code, error: error))
            }
        }
        task.resume()
    }

}

protocol URLSessionInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionInterface { }
