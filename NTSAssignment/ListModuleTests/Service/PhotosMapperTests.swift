//
//  PhotosMapperTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 18/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import XCTest
@testable import ListModule

class PhotosMapperTests: XCTestCase {

    func testPhotosMapper() {
        // given
        let photosMapper = PhotosMapperImpl()
        let photosDTO = [
            PhotosDTO(
                id: 1,
                albumId: 1,
                title: "abc",
                url: URL(string: "https://abc.com")!,
                thumbnailUrl: URL(string: "https://xyz.com")!)
        ]
        let photos = [
            Photo(
                id: 1,
                albumId: 1,
                title: "abc",
                url: URL(string: "https://abc.com")!,
                thumbnailUrl: URL(string: "https://xyz.com")!)
        ]
        
        // when
        let photosMap = photosMapper.map(input: photosDTO)
        
        // then
        XCTAssertEqual(photosMap, photos)
    }

}
