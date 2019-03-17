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

    func display(photo: Photo) {
        let detailViewController = ListDetailBuilder(photo: photo).build()
        viewController?.navigationController?.pushViewController(
            detailViewController,
            animated: true
        )
    }

}
