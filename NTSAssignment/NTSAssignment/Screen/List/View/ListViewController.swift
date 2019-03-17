//
//  ListViewController.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    var output: ListViewOutput?
    private var cellModels: [CellModel] = []
    var loading: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl() //refresh control:
        refreshControl.addTarget(self, action:
            #selector(ListViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        tableView.refreshControl = refreshControl
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let threshold: CGFloat = 100.0 // threshold from bottom of tableView
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        if (maximumOffset - contentOffset <= threshold) {
            output?.didScroll()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        output?.didPullRefresh()
    }

}

extension ListViewController: ListViewInput {

    func display(cells: [CellModel]) {
        cellModels = cells //load cells
        tableView.reloadData()
    }
    
    func displayMore(cells: [CellModel]) {
        cellModels += cells //append & load more cells
        tableView.reloadData()
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
        //stop refresh control
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
        cell.selectionStyle = .none
        (cell as? CellConfigurable)?.configure(model: cellModel)

        return cell
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelect(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }

}
