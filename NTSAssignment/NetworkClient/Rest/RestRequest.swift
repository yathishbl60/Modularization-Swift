//
//  RestRequest.swift
//  NTSAssignment
//
//  Created by Prajwal Si on 17/3/19.
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
