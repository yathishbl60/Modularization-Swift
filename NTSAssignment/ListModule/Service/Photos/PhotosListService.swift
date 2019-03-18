//
//  PhotosListService.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation
import NetworkClient

protocol PhotosListService : class {
    func fetchPhotos(request: PhotosListRequestParams, completion: @escaping (Result<[Photo]>) -> Void)
}

struct PhotosListRequestParams: Equatable {
    let page: Int
    let limit: Int
}

final class PhotosServiceIml: PhotosListService {

    let client: NetworkClient
    let mapper: PhotosMapper

    init(client: NetworkClient,
         mapper: PhotosMapper = PhotosMapperImpl()) {
        self.client = client
        self.mapper = mapper
    }

    func fetchPhotos(request: PhotosListRequestParams, completion: @escaping (Result<[Photo]>) -> Void) {
        let urlBuilder = URLBuilder(
            path: URL(string: "https://jsonplaceholder.typicode.com/photos")!,
            urlParams: [(key: "_limit", value: String(request.limit)),
                        (key: "_page", value: String(request.page))]
        )
        let endpoint = PhotosEndpoint(url: urlBuilder.build())
        client.request(endpoint: endpoint,
                       params: EmptyRequest(),
                       mapOutput: { [mapper] (dto: [PhotosDTO]) -> [Photo] in return mapper.map(input: dto) },
                       completion: completion)
    }

}

struct PhotosEndpoint: Endpoint, Equatable {

    let url: URL
    let method: RestMethod = .get
}
