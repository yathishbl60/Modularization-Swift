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
        XCTAssertTrue(view.isLoading ?? false)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }

    func testDidSelectItem() {
        // given
        let photos = mockPhotos()
        presenter.didLoad(photos: photos)
        let indexPath = IndexPath(row: 0, section: 0)
        
        // when
        presenter.didSelect(indexPath: indexPath)
        
        // then
        let photo = router.photo
        XCTAssertEqual(photo, photos.first)
    }

    func testDidPullToRefresh() {
        // when
        presenter.didPullRefresh()
        
        // then
        XCTAssertTrue(view.isLoading ?? false)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }

    func testDidScrollToBottomWhenAlreadyLoading() {
        // given
        view.isLoading = true
        
        // when
        presenter.didScrollToBottom()
        
        // then
        XCTAssertTrue(view.isLoading ?? false)
        XCTAssertTrue(interactor.loadMorePhotosCalled)
    }

    func testDidScrollToBottomWhenNotLoading() {
        // given
        view.isLoading = false
        
        // when
        presenter.didScrollToBottom()
        
        // then
        XCTAssertTrue(view.isLoading ?? false)
        XCTAssertTrue(interactor.loadMorePhotosCalled)
    }

    func testDidScrollToBottomWhenAllItemsLoaded() {
        // given
        view.isLoading = false
        presenter.didLoad(photos: [])
        
        // when
        presenter.didScrollToBottom()
        
        // then
        XCTAssertTrue((view.isLoading ?? false) == false)
        XCTAssertTrue(interactor.loadMorePhotosCalled)
    }

    func testDidLoadPhotos() {
        // given
        let photos = mockPhotos()
        
        // when
        presenter.didLoad(photos: photos)
        
        // then
        XCTAssertTrue(view.endPullRefreshingCalled)
        XCTAssertTrue(view.displayCellsCalled)
        XCTAssertEqual(
            view.cells as! [ListCellModel],
            [
                ListCellModel(title: "a", thumb: URL(string: "https://gggt.com/1")!),
                ListCellModel(title: "b", thumb: URL(string: "https://gggt.com/2")!)
            ]
        )
        XCTAssertTrue(view.isLoading!)
    }

    func testDidLoadMorePhotos() {
        // given
        let photos = mockPhotos()
        presenter.didLoad(photos: photos)

        let photos2 = [
            Photo(id: 3,
                  albumId: 13,
                  title: "c",
                  url: URL(string:  "https://g.com/3")!,
                  thumbnailUrl: URL(string:"https://gggt.com/3")!
            ),
            Photo(id: 4,
                  albumId: 44,
                  title: "d",
                  url: URL(string:"https://g.com/4")!,
                  thumbnailUrl: URL(string:"https://gggt.com/4")!
            )
        ]

        // when
        presenter.didLoadMore(photos: photos2)
        
        // then
        XCTAssertTrue(view.endPullRefreshingCalled)
        XCTAssertTrue(view.displayCellsCalled)
        XCTAssertEqual(
            view.cells as! [ListCellModel],
            [
                ListCellModel(title: "a", thumb: URL(string: "https://gggt.com/1")!),
                ListCellModel(title: "b", thumb: URL(string: "https://gggt.com/2")!),
                ListCellModel(title: "c", thumb: URL(string: "https://gggt.com/3")!),
                ListCellModel(title: "d", thumb: URL(string: "https://gggt.com/4")!)
            ]
        )
        XCTAssertTrue(view.isLoading!)
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
    
    func mockPhotos() -> [Photo] {
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
            self.cells.append(contentsOf: cells)
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
