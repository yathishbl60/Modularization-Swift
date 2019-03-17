//
//  RestCore.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

struct RestRequest {
    var url: URL
    var method: Method
    var body: [String: Any]

    init(url: URL, method: Method = .get, body: [String: Any] = [:]) {
        self.url = url
        self.method = method
        self.body = body
    }
}

struct RestResponse {
    var request: RestRequest

    var statusCode: Int
    var body: JSON
    var error: Error?

    init(request: RestRequest, statusCode: Int, body: JSON = [:], error: Error? = nil) {
        self.request = request
        self.statusCode = statusCode
        self.body = body
        self.error = error
    }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum RequestError: Error {
    case encodeError
    case parseError
}

enum ResponseError: Error {
    case transportError(kind: TransportError)
    case decodingError(internalError: Error)
    case unknown
}

enum TransportError {
    case redirect
    case internalServerError
    case badRequest
}
