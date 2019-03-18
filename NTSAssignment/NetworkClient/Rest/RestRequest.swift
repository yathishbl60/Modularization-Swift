//
//  RestRequest.swift
//  NTSAssignment
//
//  Created by Prajwal S on 17/3/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

struct RestRequest {
    var url: URL
    var method: RestMethod
    var body: [String: Any]

    init(url: URL, method: RestMethod = .get, body: [String: Any] = [:]) {
        self.url = url
        self.method = method
        self.body = body
    }
}
