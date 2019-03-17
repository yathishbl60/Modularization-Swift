//
//  ListCell.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit
import SDWebImage

final class ListCell: UITableViewCell {
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        cellImageView.sd_imageTransition = .fade
        cellImageView.layer.cornerRadius = 6
    }

}

extension ListCell: CellConfigurable {

    func configure(model: CellModel) {
        guard let model = model as? ListCellModel else { return }

        cellImageView.sd_setImage(with: model.thumb)
        cellTitle.text = model.title
    }

}

