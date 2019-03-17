//
//  Result.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

extension Result {

    var value: Value? {
        switch self {
        case .success(let item):
            return item
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let item):
            return item
        default:
            return nil
        }
    }

}
