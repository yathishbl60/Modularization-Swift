//
//  RestResponse.swift
//  NTSAssignment
//
//  Created by Prajwal Si on 17/3/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

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
