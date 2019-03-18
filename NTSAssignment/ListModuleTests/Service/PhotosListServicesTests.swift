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
    
    func testFetchPhotosReturnSuccess() {
        // given
        let photos = [
            Photo(
                id: 1,
                albumId: 1,
                title: "abc",
                url: URL(string: "http://xyz.com")!,
                thumbnailUrl:  URL(string: "http://ysdf.com")!
            ),
            Photo(
                id: 2,
                albumId: 2,
                title: "abcd",
                url: URL(string: "http://abc.com")!,
                thumbnailUrl:  URL(string: "http://dcfd.com")!
            )
        ]
        
        let mockClient = MockClient()
        mockClient.result = .success(photos)
        
        let mockMapper = PhotosMapperImpl()

        let request = PhotosListRequestParams(page: 2, limit: 10)
        let photoService = PhotosServiceIml(client: mockClient,
                                            mapper: mockMapper)
        
        // when, then
        photoService.fetchPhotos(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, photos)
            
            case .failure:
                XCTFail("Must not fail")
            }
        }

        let endPoint = PhotosEndpoint(url: URL(string: "https://jsonplaceholder.typicode.com/photos?_limit=10&_page=2")!)
        XCTAssertEqual(mockClient.endpoint as! PhotosEndpoint, endPoint)
    }
    
}

private extension PhotosListServicesTests {
    
    final class MockClient : NetworkClient {
        
        var endpoint: Endpoint? = nil
        var params: PhotosListRequestParams? = nil
        var result: Result<[Photo]>? = nil
        var photosMapper: PhotosMapper? = nil

        func request<Params, DTO, Model>(endpoint: Endpoint, params: Params, mapOutput: @escaping (DTO) throws -> Model, completion: @escaping (Result<Model>) -> Void) where Params : Encodable, DTO : Decodable {
            self.endpoint = endpoint
            self.photosMapper = mapOutput as? PhotosMapper
            self.params = params as? PhotosListRequestParams
            completion(result as! Result<Model>)
        }
    }
    
}

