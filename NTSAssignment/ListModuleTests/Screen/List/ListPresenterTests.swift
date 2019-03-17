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
        
        func display(cells: [CellModel]) {
            
        }
        
        func displayMore(cells: [CellModel]) {
            
        }
        
        func display(title: String) {
            
        }
        
        func display(isLoading: Bool) {
            
        }
        
        func endPullRefreshing() {
            
        }
        
        func displayError(message: String) {
            
        }
    }
    
    final class MockRouter: ListRouterInput {
        
        func display(photo: Photo) {
            
        }
    }
    
    final class MockInteractor: ListViewInteractorInput {
        
        func loadPhotos() {
            
        }
        
        func loadMorePhotos() {
            
        }
    }
    
}
