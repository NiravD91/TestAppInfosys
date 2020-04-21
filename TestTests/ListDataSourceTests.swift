//
//  ListDataSourceTests.swift
//  TestTests
//
//  Created by Nirav on 20/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import XCTest
@testable import Test

class ListDataSourceTests: XCTestCase {

    var dataSource: ListDataSource!

    override func setUp() {
        super.setUp()
        dataSource = ListDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {

        dataSource.data.value = []

        let tableView = UITableView()
        tableView.dataSource = dataSource

        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")

        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }

    func testValueInDataSource() {

        let row1 = RowsData(title: "Test title1",
                            description: "Test description1",
                            imageHref: "https://gravatar.com/avatar/dba6bae8c566f9d4041fb9cd9ada7741?d=identicon&f=y")
        let row2 = RowsData(title: "Test title2",
                            description: "Test description2",
                            imageHref: "https://gravatar.com/avatar/dba6bae8c566f9d4041fb9cd9ada7741?d=identicon&f=y")
        dataSource.data.value = [row1, row2]

        let tableView = UITableView()
        tableView.dataSource = dataSource

        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")

        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }

    func testValueCell() {

        let row = RowsData(title: "Test title",
                           description: "Test description",
                           imageHref: "https://gravatar.com/avatar/dba6bae8c566f9d4041fb9cd9ada7741?d=identicon&f=y")
        dataSource.data.value = [row]

        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: IDENTIFIERS.CUSTOMCELLID)

        let indexPath = IndexPath(row: 0, section: 0)

        guard dataSource.tableView(tableView, cellForRowAt: indexPath) is CustomTableViewCell else {
            XCTAssert(false, "Expected CustomTableViewCell class")
            return
        }
    }
}
