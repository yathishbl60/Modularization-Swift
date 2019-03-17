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

    func testSuccess() {
        // given
        let mockPhoto1 = Photos(id: 1,
                                albumId: 12,
                                title: "dfsdfsdf",
                                url: URL(string:  "https://g.com/1")!,
                                thumbnailUrl: URL(string:"https://gggt.com/1")!)
        let mockPhoto2 = Photos(id: 2,
                                albumId: 22,
                                title: "dfervrrr",
                                url: URL(string:"https://g.com/2")!,
                                thumbnailUrl: URL(string:"https://gggt.com/2")!)
        service.result = .success([mockPhoto1, mockPhoto2])

        // when
        interactor.loadPhotos()
        interactor.loadMorePhotos()

        // then
//        XCTAssertEqual(service.request, PhotosListRequestParams(page: 10, limit: 10))
        XCTAssertEqual(output.samples, service.result.value)
    }

    func testFailure() {
        // given
        let error = MockError.sampleError
        service.result = .failure(error)

        // when
        interactor.loadPhotos()
        interactor.loadMorePhotos()

        // then
//        XCTAssertEqual(service.request, PhotosListRequestParams(page: 10, limit: 10))
        XCTAssertEqual(output.error as! MockError,  error)
    }

}

private extension ListInteractorTests {

    final class SamplesServiceMock: PhotosListService {
        var request: PhotosListRequestParams?
        var result: Result<[Photos]>!
        func fetchPhotos(request: PhotosListRequestParams, completion: @escaping (Result<[Photos]>) -> Void) {
            self.request = request
            completion(result)
        }
    }

    final class OutputMock: ListViewInteractorOutput {
        var samples: [Photos]?
        var error: Error?
        
        func didLoad(photos: [Photos]) {
            self.samples = photos
        }
        
        func didLoadMore(photos: [Photos]) {
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
