//
//  ListServiceTests.swift
//  TestTests
//
//  Created by Nirav on 20/04/20.
//  Copyright © 2020 Nirav. All rights reserved.
//

import XCTest
@testable import Test

class ListServiceTests: XCTestCase {

    func testCancelRequest() {

        ListService.shared.fetchList { (_) in
        }

        ListService.shared.cancelFetch()
        XCTAssertNil(ListService.shared.task, "Expected task nil")
    }
}
