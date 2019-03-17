//
//  URLRequestBuilder.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

struct RestURLRequestBuilder {

    let request: RestRequest

    func build() -> URLRequest {
        var req = URLRequest(url: request.url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONSerialization.data(withJSONObject: request.body)

        return req
    }

}


public struct URLBuilder {

    public let path: URL
    public let urlParams: [String: String]

    public init(path: URL, urlParams: [String: String]) {
        self.path = path
        self.urlParams = urlParams
    }

    public func build() -> URL {
        var queries: [URLQueryItem] = []

        for (key, value) in urlParams {
            queries.append(.init(name: key, value: "\(value)"))
        }

        guard let components = NSURLComponents(string: path.absoluteString) else {
            return path
        }

        components.queryItems = queries

        return components.url ?? path
    }
    
}
