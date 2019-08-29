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
     var viewControllerUnderTest: ViewController!

     var sut: URLSession!

    override func setUp() {
         super.setUp()
         sut = URLSession(configuration: .default)
        }
    
    override func tearDown() {
          sut = nil
         super.tearDown()
    }

    func testExample() {
       
    }

    func testPerformanceExample() {
       
        self.measure {
            
        }
    }
    func testValidCallToiTunesGetsHTTPStatusCode200() {
     
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
      
        let promise = expectation(description: "Status code: 200")
        
       
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          
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
      
        wait(for: [promise], timeout: 5)
    }
    
   
}

