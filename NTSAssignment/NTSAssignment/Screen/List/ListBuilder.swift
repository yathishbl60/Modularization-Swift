//
//  ListBuilder.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

struct ListBuilder {

    func build() -> ListViewModule? {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return nil }

        let presenter = ListPresenter()
        presenter.view = viewController
        viewController.output = presenter

        let service = PhotosServiceIml(client: NetworkClientBuilder().build())
        let interactor = ListInteractor(service: service)
        interactor.output = presenter
        presenter.interactor = interactor

        let router = ListRouter()
        router.viewController = viewController
        presenter.router = router

        return viewController
    }

}
