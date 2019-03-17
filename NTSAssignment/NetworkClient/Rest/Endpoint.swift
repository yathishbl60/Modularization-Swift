//
//  Endpoint.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var url: URL { get }
    var method: Method { get }
}

public protocol EndpointProvider {
    var endpoint: Endpoint { get }
}

public enum Method: String {
    case get = "GET"
    case post = "POST"
}
