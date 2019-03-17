//
//  Serializer.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol Serializer {
    func map<T: Decodable>(response: RestResponse) throws -> T
}

struct JsonSerializer: Serializer {

    func map<T: Decodable>(response: RestResponse) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: response.body, options: .prettyPrinted)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ResponseError.decodingError(internalError: error)
        }
    }

}

extension Encodable {

    func dictionary() throws -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                throw RequestError.parseError
        }
        return dictionary
    }

}
