//
//  ListModule.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

typealias ListViewModule = UIViewController

protocol ListViewInput: class {
    func display(cells: [CellModel])
    func displayMore(cells: [CellModel])
    func display(title: String)
    var isLoading:Bool {get set}
    func endPullRefreshing()
    func displayError(message: String)
}

protocol ListViewOutput {
    func viewDidLoad()
    func didSelect(indexPath: IndexPath)
    func didPullRefresh()
    func didScroll()
}

protocol ListRouterInput: class {
    func display(photos: Photos)
}

protocol ListViewInteractorInput {
    func loadPhotos()
    func loadMorePhotos()
}

protocol ListViewInteractorOutput: class {
    func didLoad(photos: [Photos])
    func didLoadMore(photos: [Photos])
    func didFailToLoadPhotos(error: Error)
}

