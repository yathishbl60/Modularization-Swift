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
        view?.display(isLoading: true)
        interactor?.loadPhotos()
    }

    func didSelect(indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        router?.display(photo: photo)
    }

    func didPullRefresh() {
        loadedAllPhotos = false
        view?.display(isLoading: true)
        interactor?.loadPhotos()
    }
    
    func didScrollToBottom() {
        guard !loadedAllPhotos else { return }

        view?.display(isLoading: !loadedAllPhotos)
        interactor?.loadMorePhotos()
    }
}

extension ListPresenter: ListViewInteractorOutput {
    
    func didLoad(photos: [Photo]) {
        loadedAllPhotos = photos.isEmpty
        self.photos = photos
        view?.endPullRefreshing()
        view?.display(cells: map(photos: photos))
        view?.display(isLoading: !loadedAllPhotos)
    }

    func didLoadMore(photos: [Photo]) {
        loadedAllPhotos = photos.isEmpty
        self.photos += photos
        view?.endPullRefreshing()
        view?.displayMore(cells: map(photos: photos))
        view?.display(isLoading: !loadedAllPhotos)
    }

    func didFailToLoadPhotos(error: Error) {
        view?.display(isLoading: false)
        view?.endPullRefreshing()
        view?.displayError(message: map(error: error))
    }

}

private extension ListPresenter {

    func map(photos: [Photo]) -> [CellModel] {
        return photos.map {
            ListCellModel(title: $0.title, thumb: $0.thumbnailUrl)
        }
    }

    func map(error: Error) -> String {
        return "Something went wrong!!"
    }

}
