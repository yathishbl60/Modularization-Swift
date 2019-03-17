//
//  ListCellModel.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

//View Model

struct ListCellModel: CellModel {
    static let cellId: String = String(describing: ListCell.self)
    let title: String
    let url: URL
    let thumb: URL
}
