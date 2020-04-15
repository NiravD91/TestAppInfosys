//
//  CustomViewController.swift
//  Test
//
//  Created by Nirav on 15/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    // MARK: - All variables declaration here....
    let tblView = UITableView()
    var arrRows = [RowsData]()
    let refreshControl = UIRefreshControl()

    // MARK:- UIViewController lifecycle methods here....
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tblView)

        setConstraintsOfTableView()

        tblView.dataSource = self
        tblView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tblView.refreshControl = refreshControl
        
        tblView.register(CustomTableViewCell.self, forCellReuseIdentifier: IDENTIFIERS.CUSTOM_CELL_ID)
        
        navigationItem.title = "About Canada"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ServerManager.callApi(completion: {
            (arr, error) in
            self.arrRows = arr?.rows ?? []
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        })
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
        
        ServerManager.callApi(completion: {
            (arr, error) in
            self.arrRows = arr?.rows ?? []
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
}

extension CustomViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView dataSource Methods here....
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIERS.CUSTOM_CELL_ID, for: indexPath) as! CustomTableViewCell
        cell.listRows = arrRows[indexPath.row]
        
        return cell
    }
}
