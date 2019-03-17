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

    let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }
}

extension DetailPresenter: DetailViewOutput {
    
    func viewDidLoad() {
        view?.display(title: "Photo Detail")
        view?.display(image: photo.url)
        view?.displayText(text: photo.title)
    }

}
