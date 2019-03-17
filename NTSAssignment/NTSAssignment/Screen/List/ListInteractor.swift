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
    private var request: PhotosListRequestParams
    private let firstPageRequest = PhotosListRequestParams(page: 0, limit: 10)
    
    init(service: PhotosListService) {
        self.service = service
        request = firstPageRequest
    }

    func performRequest() {
        let currentRequest = request
        service.fetchPhotos(request: request) { [weak self] response in
            switch response {
            case .success(let photos):
                if currentRequest.page > 0 {
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
        request = firstPageRequest //load start page!
        performRequest()
    }

    func loadMorePhotos() {
        request = PhotosListRequestParams(page: request.page + 1, limit: request.limit) //load next page!
        performRequest()
    }
}
