//
//  ListViewController.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController, StoryboardIdentifiable {
    
    var output: ListViewOutput?
    private var cellModels: [CellModel] = []
    private var loading: Bool = false
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .gray

        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()

        output?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    @objc private func handleRefresh() {
        output?.didPullRefresh()
    }

}

extension ListViewController: ListViewInput {

    func display(cells: [CellModel]) {
        cellModels = cells
        tableView.reloadData()
    }
    
    func displayMore(cells: [CellModel]) {
        var insertedIndexPaths: [IndexPath] = []
        for (index, _) in cells.enumerated() {
            insertedIndexPaths.append(IndexPath(row: index + cellModels.endIndex, section: 0))
        }

        cellModels += cells

        tableView.beginUpdates()
        tableView.insertRows(at: insertedIndexPaths, with: .automatic)
        tableView.endUpdates()
    }

    func display(title: String) {
        self.title = title
    }
    
    var isLoading: Bool {
        get {
            return loading
        }
        set {
            loading = isLoading
            tableView.tableFooterView?.isHidden = !loading
        }
    }

    func endPullRefreshing() {
        refreshControl.endRefreshing()
    }

    func displayError(message: String) {
        //display error alert!
        
    }

}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellModel).cellId, for: indexPath)
        (cell as? CellConfigurable)?.configure(model: cellModel)

        return cell
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelect(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        guard lastSectionIndex >= 0 else { return }

        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        guard lastRowIndex >= 0 else { return }

        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            // display load more indicator
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }

}

extension ListViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let threshold: CGFloat = 100.0 // threshold from bottom of tableView
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        if (maximumOffset - contentOffset <= threshold) {
            output?.didScrollToBottom()
        }
    }

}
