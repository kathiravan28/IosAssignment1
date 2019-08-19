//
//  IosAssignmentTests.swift
//  IosAssignmentTests
//
//  Created by kathiravan Raju on 18/08/19.
//  Copyright © 2019 kathiravan Raju. All rights reserved.
//

import XCTest
@testable import IosAssignment

class IosAssignmentTests: XCTestCase {
    
     var sut: URLSession!

    override func setUp() {
         super.setUp()
         sut = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
          sut = nil
         super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        // given
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
}

