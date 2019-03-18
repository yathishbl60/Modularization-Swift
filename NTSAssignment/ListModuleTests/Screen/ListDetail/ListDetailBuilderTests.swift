//
//  ListDetailBuilderTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import XCTest
@testable import ListModule

final class ListDetailBuilderTests: XCTestCase {

    func testBuild() {
        // given
        let photo = Photo(
            id: 1,
            albumId: 1,
            title: "abc",
            url: URL(string: "http://xyz.com")!,
            thumbnailUrl:  URL(string: "http://ysdf.com")!
        )
        let listDetailBuilder = ListDetailBuilder(photo: photo)
        
        // when
        let viewController = listDetailBuilder.build()

        // then
        XCTAssertTrue(viewController is DetailViewController)
        let listViewController = viewController as! DetailViewController
        XCTAssertTrue(listViewController.output is DetailPresenter)
        
        let presenter = listViewController.output as! DetailPresenter
        XCTAssertTrue(presenter.view === viewController)
        
    }

}
