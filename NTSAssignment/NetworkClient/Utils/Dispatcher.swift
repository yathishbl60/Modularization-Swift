//
//  Dispatcher.swift
//  NTSAssignment
//
//  Created by Prajwal S. on 17/3/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol Dispatcher {
    func dispacthAsync(execute:  @escaping () -> Void)
}

extension DispatchQueue: Dispatcher {

    func dispacthAsync(execute: @escaping () -> Void) {
        async(execute: execute)
    }

}
