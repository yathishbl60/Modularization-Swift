//
//  PhotosMapper.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import Foundation

protocol PhotosMapper {
    func map(input: [PhotosDTO]) -> [Photos]
}

struct PhotosMapperImpl: PhotosMapper {

    func map(input: [PhotosDTO]) -> [Photos] {
        return input.map {
            Photos(id: $0.id, albumId: $0.albumId, title: $0.title, url: $0.url, thumbnailUrl: $0.thumbnailUrl)
        }
    }

}
