//
//  ListInteractor.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

final class ListInteractor {
    weak var output: ListViewInteractorOutput?
    let service: PhotosListService
    var request: PhotosListRequestParams!
    
    init(service: PhotosListService) {
        self.service = service
    }

    func performRequest() {
        service.fetchPhotos(request: request) { [weak self] response in
            switch response {
            case .success(let photos):
                if let page = self?.request.page, page > 0 {
                    self?.output?.didLoadMore(photos: photos)
                } else {
                    self?.output?.didLoad(photos: photos)
                }
            case .failure(let error):
                self?.output?.didFailToLoadPhotos(error: error)
            }
        }
    }
}

extension ListInteractor: ListViewInteractorInput {

    func loadPhotos() {
        request = PhotosListRequestParams(page: 0, limit: 10) //load start page!
        performRequest()
    }

    func loadMorePhotos() {
        request = PhotosListRequestParams(page: request.page+1, limit: request.limit) //load next page!
        performRequest()
    }
}
