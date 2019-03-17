//
//  ListModule.swift
//  NTSAssignment
//
//  Created by Prajwal S on 16/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

public typealias ListViewModule = UIViewController

protocol ListViewInput: class {
    func display(cells: [CellModel])
    func displayMore(cells: [CellModel])
    func display(title: String)
    func display(isLoading: Bool)
    func endPullRefreshing()
    func displayError(message: String)
}

protocol ListViewOutput {
    func viewDidLoad()
    func didSelect(indexPath: IndexPath)
    func didPullRefresh()
    func didScrollToBottom()
}

protocol ListRouterInput: class {
    func display(photo: Photo)
}

protocol ListViewInteractorInput {
    func loadPhotos()
    func loadMorePhotos()
}

protocol ListViewInteractorOutput: class {
    func didLoad(photos: [Photo])
    func didLoadMore(photos: [Photo])
    func didFailToLoadPhotos(error: Error)
}

