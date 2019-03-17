//
//  ListPresenter.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

final class ListPresenter {
    weak var view: ListViewInput?
    var interactor: ListViewInteractorInput?
    var router: ListRouterInput?

    private var photos: [Photos] = []
}

extension ListPresenter: ListViewOutput {

    func viewDidLoad() {
        view?.display(title: "Photos List")
        view?.isLoading = true
        interactor?.loadPhotos()
    }

    func didSelect(indexPath: IndexPath) {
        if indexPath.row < photos.count {
            let photo = photos[indexPath.row]
            router?.display(photos: photo)
        }
    }

    func didPullRefresh() {
        view?.isLoading = true
        interactor?.loadPhotos()
    }
    
    func didScroll() {
        if let isLoading = view?.isLoading, !isLoading {
            view?.isLoading = true
            interactor?.loadMorePhotos()
        }
    }
}

extension ListPresenter: ListViewInteractorOutput {
    
    func didLoad(photos: [Photos]) {
        DispatchQueue.main.async {
            self.photos = photos
            self.view?.isLoading = false
            self.view?.endPullRefreshing()
            self.view?.display(cells: self.map(photos: photos))
        }
    }

    func didLoadMore(photos: [Photos]) {
        DispatchQueue.main.async {
            self.photos += photos
            self.view?.isLoading = false
            self.view?.endPullRefreshing()
            self.view?.displayMore(cells: self.map(photos: photos))
        }
    }
    
    func didFailToLoadPhotos(error: Error) {
        DispatchQueue.main.async {
            self.view?.isLoading = false
            self.view?.endPullRefreshing()
            self.view?.displayError(message: self.map(error: error))
        }
    }

}

private extension ListPresenter {

    func map(photos: [Photos]) -> [CellModel] {
        return photos.map {
            ListCellModel(title: $0.title, url: $0.url, thumb: $0.thumbnailUrl)
        }
    }

    func map(error: Error) -> String {
        return "please check!! error mapping data"
    }

}
