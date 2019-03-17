//
//  Endpoint.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol Endpoint {
    var url: URL { get }
    var method: Method { get }
}

protocol EndpointProvider {
    var endpoint: Endpoint { get }
}
