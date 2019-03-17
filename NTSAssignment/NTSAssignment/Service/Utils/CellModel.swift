//
//  CellModel.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol CellModel {
    static var cellId: String { get }
}

protocol CellConfigurable {
    func configure(model: CellModel)
}
