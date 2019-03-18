//
//  PhotosListServicesTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 18/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import XCTest
@testable import ListModule
@testable import NetworkClient

final class PhotosListServicesTests: XCTestCase {
    
    func testPhotosServicesRequest() {
        // given
        let photoServiceImpl: PhotosServiceIml = PhotosServiceIml(client: NetworkClientBuilder().build())
        let expectation = self.expectation(description: "fetchPhotos")
        let request = PhotosListRequestParams(page: 0, limit: 10)
        var photosData: [Photo] = []
        // when
        photoServiceImpl.fetchPhotos(request: request) { response in
            switch response {
            case .success(let photos):
                photosData = photos
            case .failure(_): break
            }
            XCTAssertTrue(response.error == nil)
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(photosData.count, 10)
    }
    
}
