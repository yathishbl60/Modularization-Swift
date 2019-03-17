//
//  ResponseInterceptor.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol ResponseInterceptor {
    mutating func intercept(response: Response) throws -> Response
}

struct StatusCodeCheckInterceptor: ResponseInterceptor {

    func intercept(response: Response) throws -> Response {
        switch response.statusCode {
        case 100...200:
            return response
        case 201...300:
            throw ResponseError.transportError(kind: .redirect)
        case 301...400:
            throw ResponseError.transportError(kind: .badRequest)
        case 401...500:
            throw ResponseError.transportError(kind: .internalServerError)
        default:
            throw ResponseError.unknown
        }
    }

}
