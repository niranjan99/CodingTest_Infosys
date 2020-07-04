//
//  MockFeedsService.swift
//  CodingTestInfosys
//
//  Created by Niranjan on 04/07/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//
import Foundation
@testable import CodingTestInfosys

class MockFeedsService {
    var feedsData: FeedsModel?
    func fetchFeeds(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void)) {
        if let data = feedsData {
            completion(Result.success(data))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}
