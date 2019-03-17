//
//  ListDetailBuilder.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

struct ListDetailBuilder {
    func buildWithPhotoData(_ photo: Photos) -> DetailViewModule? {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return nil }
        
        let presenter = DetailPresenter()
        presenter.photoData = photo //passing data!
        presenter.view = viewController
        viewController.output = presenter
        
        return viewController
    }
}
