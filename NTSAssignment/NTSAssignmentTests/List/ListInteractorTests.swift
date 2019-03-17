//
//  ListInteractorTests.swift
//  NTSAssignmentTests
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

@testable import NTSAssignment
import XCTest

final class ListInteractorTests: XCTestCase {

    private var interactor: ListInteractor!
    private var service: SamplesServiceMock!
    private var output: OutputMock!

    override func setUp() {
        super.setUp()

        service = SamplesServiceMock()
        output = OutputMock()
        interactor = ListInteractor(service: service)
        interactor.output = output
    }

    override func tearDown() {
        interactor = nil
        service = nil
        output = nil

        super.tearDown()
    }

    func testLoadPhotosSuccess() {
        // given
        let mockPhoto1 = Photo(id: 1,
                               albumId: 12,
                               title: "a",
                               url: URL(string:  "https://g.com/1")!,
                               thumbnailUrl: URL(string:"https://gggt.com/1")!)
        let mockPhoto2 = Photo(id: 2,
                               albumId: 22,
                               title: "b",
                               url: URL(string:"https://g.com/2")!,
                               thumbnailUrl: URL(string:"https://gggt.com/2")!)
        service.result = .success([mockPhoto1, mockPhoto2])

        // when
        interactor.loadPhotos()

        // then
        XCTAssertEqual(service.request, PhotosListRequestParams(page: 0, limit: 10))
        XCTAssertEqual(output.samples, service.result.value)
    }

    func testLoadMorePhotosSuccess() {
        // given
        let mockPhoto1 = Photo(id: 1,
                               albumId: 12,
                               title: "a",
                               url: URL(string:  "https://g.com/1")!,
                               thumbnailUrl: URL(string:"https://gggt.com/1")!)
        let mockPhoto2 = Photo(id: 2,
                               albumId: 22,
                               title: "b",
                               url: URL(string:"https://g.com/2")!,
                               thumbnailUrl: URL(string:"https://gggt.com/2")!)
        service.result = .success([mockPhoto1, mockPhoto2])

        // when
        interactor.loadMorePhotos()

        // then
        XCTAssertEqual(service.request, PhotosListRequestParams(page: 1, limit: 10))
        XCTAssertEqual(output.samples, service.result.value)

        interactor.loadMorePhotos()
        XCTAssertEqual(service.request, PhotosListRequestParams(page: 2, limit: 10))
    }

    func testLoadPhotosFailure() {
        // given
        let error = MockError.sampleError
        service.result = .failure(error)

        // when
        interactor.loadPhotos()

        // then
        XCTAssertEqual(service.request, PhotosListRequestParams(page: 0, limit: 10))
        XCTAssertEqual(output.error as! MockError,  error)
    }

    func testLoadMorePhotosFailure() {
        // given
        let error = MockError.sampleError
        service.result = .failure(error)

        // when
        interactor.loadMorePhotos()

        // then
        XCTAssertEqual(service.request, PhotosListRequestParams(page: 1, limit: 10))
        XCTAssertEqual(output.error as! MockError,  error)
    }

}

private extension ListInteractorTests {

    final class SamplesServiceMock: PhotosListService {
        var request: PhotosListRequestParams?
        var result: Result<[Photo]>!
        func fetchPhotos(request: PhotosListRequestParams, completion: @escaping (Result<[Photo]>) -> Void) {
            self.request = request
            completion(result)
        }
    }

    final class OutputMock: ListViewInteractorOutput {
        var samples: [Photo]?
        var error: Error?
        
        func didLoad(photos: [Photo]) {
            self.samples = photos
        }
        
        func didLoadMore(photos: [Photo]) {
            self.samples = photos
        }
        
        func didFailToLoadPhotos(error: Error) {
            self.error = error
        }
    }

    enum MockError: Error {
        case sampleError
    }

}
