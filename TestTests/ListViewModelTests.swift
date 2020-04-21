//
//  ListViewModelTests.swift
//  TestTests
//
//  Created by Nirav on 20/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import XCTest
@testable import Test

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!
    var dataSource: GenericDataSource<RowsData>!
    fileprivate var service: MockListService!

    override func setUp() {
        super.setUp()
        self.service = MockListService()
        self.dataSource = GenericDataSource<RowsData>()
        self.viewModel = ListViewModel(service: service, dataSource: dataSource)
    }

    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchWithNoService() {

        let expectation = XCTestExpectation(description: "No service list")

        viewModel.service = nil

        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }

        viewModel.fetchRows()
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchRows() {

        let expectation = XCTestExpectation(description: "Rows fetch")

        service.listData = ListData(title: "Test Title", rows: [])

        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }

        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }

        viewModel.fetchRows()
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchNoRows() {

        let expectation = XCTestExpectation(description: "No lists")

        service.listData = nil

        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }

        viewModel.fetchRows()
        wait(for: [expectation], timeout: 5.0)
    }
}

private class MockListService: ListServiceProtocol {

    var listData: ListData?

    func fetchList(_ completion: @escaping ((Result<ListData, ErrorResult>) -> Void)) {

        if let listData = listData {
            completion(Result.success(listData))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No list")))
        }
    }
}
