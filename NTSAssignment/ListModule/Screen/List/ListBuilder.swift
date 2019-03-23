//
//  ListBuilder.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit
import NetworkClient

public struct ListBuilder {

    public init() { }

    public func build() -> ListModule {
        let viewController: ListViewController = UIStoryboard(storyboard: .Main).instantiateViewController()

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
