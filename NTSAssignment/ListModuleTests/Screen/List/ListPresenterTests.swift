//
//  ListPresenterTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import XCTest
@testable import ListModule

final class ListPresenterTests: XCTestCase {
    
    private var presenter: ListPresenter!
    private var router: MockRouter!
    private var view: MockView!
    private var interactor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        
        presenter = ListPresenter()
        router = MockRouter()
        view = MockView()
        interactor = MockInteractor()

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
    }

    override func tearDown() {
        presenter = nil
        router = nil
        view = nil
        interactor = nil

        super.tearDown()
    }

    func testViewIsReady() {
        // when
        presenter.viewDidLoad()
        
        // then
        XCTAssertEqual(view.title, "Photos")
        XCTAssertTrue(view.isLoading!)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }

    func testDidSelectItem() {
        // given
        presenter.didLoad(photos: mockPhotos)
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        presenter.didSelect(indexPath: indexPath)
        
        // then
        let photo = router.photo
        XCTAssertEqual(photo, mockPhotos.first)
    }

    func testDidPullToRefresh() {
        // when
        presenter.didPullRefresh()
        
        // then
        XCTAssertTrue(view.isLoading!)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }

    func testDidScrollToBottom() {
        // when
        presenter.didScrollToBottom()
        
        // then
        XCTAssertTrue(view.isLoading!)
        XCTAssertTrue(interactor.loadMorePhotosCalled)
    }

    func testDidLoadPhotos() {
        // given
        let photos = mockPhotos
        
        // when
        presenter.didLoad(photos: photos)
        
        // then
        XCTAssertTrue(view.endPullRefreshingCalled)
        XCTAssertTrue(view.displayCellsCalled)
        XCTAssertTrue(view.cells.count == 2)
        XCTAssertTrue(view.isLoading ?? false)
    }

    func testDidLoadMorePhotos() {
        // given
        presenter.didLoad(photos: mockPhotos)
        
        // when
        presenter.didLoadMore(photos: mockPhotos)
        
        // then
        XCTAssertTrue(view.endPullRefreshingCalled)
        XCTAssertTrue(view.displayCellsCalled)
        XCTAssertTrue(view.cells.count == 2)
        XCTAssertTrue(view.isLoading ?? false)
    }

    func testDidFailToLoadPhotos() {
        // given
        let error = MockError.sampleError
        
        // when
        presenter.didFailToLoadPhotos(error: error)
        
        // then
        XCTAssertTrue((view.isLoading ?? false) == false)
        XCTAssertTrue(view.endPullRefreshingCalled)
        XCTAssertEqual(view.errorMessage, "Something went wrong!!")
    }
    
}

private extension ListPresenterTests {
    
    var mockPhotos: [Photo] {
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
        let photos = [mockPhoto1, mockPhoto2]
        return photos
    }
    
    enum MockError: Error {
        case sampleError
    }
    
    final class MockView: ListViewInput {

        var cells: [CellModel] = []

        var displayCellsCalled = false
        func display(cells: [CellModel]) {
            displayCellsCalled = true
            self.cells = cells
        }

        var displayMoreCellsCalled = false
        func displayMore(cells: [CellModel]) {
            self.cells = cells
            displayMoreCellsCalled = true
        }

        var title: String?
        func display(title: String) {
            self.title = title
        }

        var isLoading: Bool?
        func display(isLoading: Bool) {
            self.isLoading = isLoading
        }

        var endPullRefreshingCalled = false
        func endPullRefreshing() {
            endPullRefreshingCalled = true
        }

        var errorMessage: String?
        func displayError(message: String) {
            errorMessage = message
        }

    }
    
    final class MockRouter: ListRouterInput {

        var photo: Photo?
        func display(photo: Photo) {
            self.photo = photo
        }

    }
    
    final class MockInteractor: ListViewInteractorInput {

        var loadPhotosCalled = false
        func loadPhotos() {
            loadPhotosCalled = true
        }

        var loadMorePhotosCalled = false
        func loadMorePhotos() {
            loadMorePhotosCalled = true
        }
    }
    
}
