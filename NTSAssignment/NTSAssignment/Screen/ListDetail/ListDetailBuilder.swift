//
//  ListDetailBuilder.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

struct ListDetailBuilder {
    let photo: Photo

    func build() -> DetailViewModule {
        let viewController: DetailViewController = UIStoryboard(storyboard: .Main).instantiateViewController()
        
        let presenter = DetailPresenter(photo: photo)
        presenter.view = viewController
        viewController.output = presenter
        
        return viewController
    }
}
