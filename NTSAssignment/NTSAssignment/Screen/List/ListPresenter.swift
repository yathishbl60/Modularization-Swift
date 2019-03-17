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
    private var photos: [Photo] = []
    private var loadedAllPhotos = false
}

extension ListPresenter: ListViewOutput {

    func viewDidLoad() {
        view?.display(title: "Photos")
        view?.isLoading = true
        interactor?.loadPhotos()
    }

    func didSelect(indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        router?.display(photo: photo)
    }

    func didPullRefresh() {
        loadedAllPhotos = false
        view?.isLoading = true
        interactor?.loadPhotos()
    }
    
    func didScrollToBottom() {
        view?.isLoading = !loadedAllPhotos
        interactor?.loadMorePhotos()
    }
}

extension ListPresenter: ListViewInteractorOutput {
    
    func didLoad(photos: [Photo]) {
        loadedAllPhotos = photos.isEmpty
        self.photos = photos
        view?.isLoading = !loadedAllPhotos
        view?.endPullRefreshing()
        view?.display(cells: map(photos: photos))
    }

    func didLoadMore(photos: [Photo]) {
        loadedAllPhotos = photos.isEmpty
        self.photos += photos
        view?.isLoading = !loadedAllPhotos
        view?.endPullRefreshing()
        view?.displayMore(cells: map(photos: photos))
    }

    func didFailToLoadPhotos(error: Error) {
        view?.isLoading = false
        view?.endPullRefreshing()
        view?.displayError(message: map(error: error))
    }

}

private extension ListPresenter {

    func map(photos: [Photo]) -> [CellModel] {
        return photos.map {
            ListCellModel(title: $0.title, url: $0.url, thumb: $0.thumbnailUrl)
        }
    }

    func map(error: Error) -> String {
        return "Something went wrong!!"
    }

}
