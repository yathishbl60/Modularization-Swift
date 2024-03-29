//
//  ListCellModel.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

struct ListCellModel: CellModel, Equatable {
    static let cellId: String = String(describing: ListCell.self)

    let title: String
    let thumb: URL
}
