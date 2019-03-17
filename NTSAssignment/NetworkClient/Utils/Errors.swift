//
//  Errors.swift
//  NTSAssignment
//
//  Created by Prajwal Si on 17/3/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

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
