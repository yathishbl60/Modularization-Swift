//
//  DetailPresenter.swift
//  NTSAssignment
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

final class DetailPresenter {
    weak var view: DetailViewInput?
    var interactor: DetailViewInteractorInput?
    var router: DetailRouterInput?
    var photoData: Photos?
}

extension DetailPresenter: DetailViewOutput {
    
    func viewDidLoad() {
        view?.display(title: "Photo Detail")
        if let imageUrl = photoData?.url {
            view?.display(image: imageUrl)
        }
        if let detailText = photoData?.title {
            view?.displayText(text: detailText)
        }
    }
}
