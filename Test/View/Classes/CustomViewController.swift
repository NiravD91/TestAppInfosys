//
//  CustomViewController.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomViewController: UIViewController {

    // MARK: - All variables declaration here....
    let tblView = UITableView()
    var arrRows = [RowsData]()
    let refreshControl = UIRefreshControl()

    let dataSource = ListDataSource()

    lazy var viewModel: ListViewModel = {
        let viewModel = ListViewModel(dataSource: dataSource)
        return viewModel
    }()

    // MARK: - UIViewController lifecycle methods here....
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tblView)

        setConstraintsOfTableView()

        tblView.dataSource = self.dataSource
        tblView.rowHeight = 44

        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tblView.refreshControl = refreshControl

        navigationItem.title = "About Canada"

        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tblView.reloadData()
        }

        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured",
                                               message: "Oops, something went wrong!",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }

        self.viewModel.fetchRows()

        tblView.register(CustomTableViewCell.self, forCellReuseIdentifier: IDENTIFIERS.CUSTOMCELLID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func setConstraintsOfTableView() {
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tblView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tblView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tblView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - PullToRefresh method here....
    @objc func refresh() {
        self.arrRows = []

        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tblView.reloadData()
        }

        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured",
                                               message: "Oops, something went wrong!",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }

        self.viewModel.fetchRows()
        refreshControl.endRefreshing()
    }
}
