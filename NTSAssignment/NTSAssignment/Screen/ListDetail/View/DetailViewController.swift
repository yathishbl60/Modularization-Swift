//
//  DetailViewController.swift
//  NTSAssignment
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    var output: DetailViewOutput?

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        output?.viewDidLoad()
    }
}

extension DetailViewController: DetailViewInput {
    
    func display(title: String) {
        self.title = title
    }

    func display(image: URL) {
        detailImageView.sd_setImage(with: image)
    }
    
    func displayText(text: String) {
        detailTextLabel.text = text
    }
}
