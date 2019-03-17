//
//  ListRouter.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

final class ListRouter {
    weak var viewController: UIViewController?
}

extension ListRouter: ListRouterInput {

    func display(photos: Photos) {
        if let detailViewController = ListDetailBuilder().buildWithPhotoData(photos) as? DetailViewController {
            viewController?.navigationController?.pushViewController(
                detailViewController,
                animated: true
            )
        }
    }

}
