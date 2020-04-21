//
//  ListTests.swift
//  TestTests
//
//  Created by Nirav on 20/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import XCTest
@testable import Test

class ListTests: XCTestCase {

    func testParseEmptyList() {

        let data = Data()

        let completion: ((Result<ListData, ErrorResult>) -> Void) = { result in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }

        ParserHelper.parse(data: data, completion: completion)
    }

    func testParseRows() {

        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }

        let completion: ((Result<ListData, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid list")
            case .success(let listData):

                XCTAssertEqual(listData.title, "Test", "Expected Test title")
                XCTAssertEqual(listData.rows.count, 32, "Expected 32 rows")
            }
        }

        ParserHelper.parse(data: data, completion: completion)
    }

    func testWrongKeyRows() {

        let dictionary = ["test": 123 as AnyObject]

        let result = ListData.parseObject(dictionary: dictionary)

        switch result {
        case .success:
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}
