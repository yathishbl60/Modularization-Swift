//
//  ListBuilderTests.swift
//  NTSAssignmentTests
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

@testable import ListModule
import XCTest

final class ListBuilderTests: XCTestCase {

    func testBuild() {
        // given
        let listBuilder = ListBuilder()
        
        // when
        let viewController = listBuilder.build()
        
        // then
        XCTAssertTrue(viewController is ListViewController)
        let listViewController = viewController as! ListViewController
        XCTAssertTrue(listViewController.output is ListPresenter)
        
        let presenter = listViewController.output as! ListPresenter
        XCTAssertTrue(presenter.view === viewController)
        
        let interactor = presenter.interactor as! ListInteractor
        XCTAssertTrue(interactor.service is PhotosServiceIml)
        XCTAssertTrue(interactor.output === presenter)
        
        let router = presenter.router as! ListRouter
        XCTAssertTrue(router.viewController === viewController)
        XCTAssertTrue(presenter.router === router)
    }
    
}
