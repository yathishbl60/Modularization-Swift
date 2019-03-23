//
//  ListRouterTests.swift
//  ListModuleTests
//
//  Created by Prajwal S on 17/3/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

@testable import ListModule
import UIKit
import XCTest

final class ListRouterTests: XCTestCase {

    func testDisplayDetail() {
        // given
        let router = ListRouter()
        let viewController = MockViewController()
        router.viewController = viewController

        let photo = Photo(
            id: 1,
            albumId: 2,
            title: "a",
            url: URL(string: "http://x.com")!,
            thumbnailUrl:  URL(string: "http://y.com")!
        )

        // when
        router.display(photo: photo)

        // then
        XCTAssertTrue(viewController.mackNavigationController.animated!)
        XCTAssertNotNil(viewController.mackNavigationController.viewControllerToPush)
    }

}

private extension ListRouterTests {

    final class MockViewController: UIViewController {

        let mackNavigationController = MockNavigationController()
        override var navigationController: UINavigationController? {
            return mackNavigationController
        }
        
    }

    final class MockNavigationController: UINavigationController {

        var viewControllerToPush: UIViewController?
        var animated: Bool?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            viewControllerToPush = viewController
            self.animated = animated
        }

    }

}
