//
//  DetailPresenterTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 17/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import XCTest
@testable import ListModule

final class DetailPresenterTests: XCTestCase {
    
    private var presenter: DetailPresenter!
    private var view: DetailMockView!
    private var photo: Photo!
    
    override func setUp() {
        super.setUp()
        photo = Photo(
            id: 1,
            albumId: 1,
            title: "sfds",
            url: URL(string: "http://abc.com")!,
            thumbnailUrl:  URL(string: "http://ysdf.com")!
        )
        presenter = DetailPresenter(photo: photo)
        view = DetailMockView()
        presenter.view = view
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        super.tearDown()
    }
    
    func testViewIsReady() {
        // when
        presenter.viewDidLoad()
        
        // then
        XCTAssertEqual(view.detailModel!.title, "Detail")
        XCTAssertEqual(view.detailModel!.imageDescription, photo.title)
        XCTAssertEqual(view.detailModel!.imageUrl, photo.url)
    }

}

private extension DetailPresenterTests {
    
    final class DetailMockView: DetailViewInput {
        
        var detailModel: DetailViewModel?

        func display(model: DetailViewModel) {
            detailModel = model
        }
    }

}
