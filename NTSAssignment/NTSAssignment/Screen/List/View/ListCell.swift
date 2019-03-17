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
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 1
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        containerView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cellImageView.layer.cornerRadius = 10
        cellImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        cellImageView.layer.masksToBounds = true
    }
}

extension ListCell: CellConfigurable {

    func configure(model: CellModel) {
        guard let model = model as? ListCellModel else { return }
//        print("updated cell with model: \(model)")
        cellImageView.sd_setImage(with: model.thumb)
        cellTitle.text = model.title
    }

}

