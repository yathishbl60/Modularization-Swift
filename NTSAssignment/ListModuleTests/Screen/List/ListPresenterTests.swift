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
//        router.display(photo: <#T##Photo#>)
    }
    
}


private extension ListPresenterTests {
    
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
