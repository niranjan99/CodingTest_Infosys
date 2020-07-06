//
//  FactsViewModelTests.swift
//  CodingTestInfosys
//
//  Created by Niranjan on 04/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

@testable import CodingTestInfosys
import XCTest

class FactsViewModelTests: XCTestCase {

    var viewModel: FactsViewModel!

    override func setUp() {
        super.setUp()
        self.viewModel = FactsViewModel()
    }

    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchFeeds() {
        viewModel.service.loadData { jsonArray in
                       switch jsonArray {
                       case .success(let response):
                         XCTAssertEqual(response.title, "About Canada")
                         if let list = response.rows {
                             XCTAssertEqual(list.count, 14, "Expected 14 rates")
                         }
                         else {
                             XCTAssert(false, "Expected valid ListModel")
                         }
                       case .failure:
                          XCTAssert(false, "ViewModel should not be able to fetch without service")
                       }
        }
          }
    }
