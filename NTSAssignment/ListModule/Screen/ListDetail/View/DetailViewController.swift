//
//  DetailViewController.swift
//  NTSAssignment
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, StoryboardIdentifiable {

    var output: DetailViewOutput?

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.sd_imageTransition = .fade
        output?.viewDidLoad()
    }
}

extension DetailViewController: DetailViewInput {
    
    func display(model: DetailViewModel) {
        self.title = model.title
        detailImageView.sd_setImage(with: model.imageUrl)
        detailTextLabel.text = model.imageDescription
    }
}
