//
//  TidepoolKitTests.swift
//  TidepoolKitTests
//
//  Created by Ethan Look on 8/7/16.
//  Copyright © 2016 Ethan Look. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class TidepoolKitTests: XCTestCase {
    
    var api: Api = Api()
    
    let username = ""
    let password = ""
    
    override func setUp() {
        super.setUp()
        let expectation = expectationWithDescription("Login")

        self.api.login(self.username, password: self.password) { (response, data, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogout() {
        let expectation = expectationWithDescription("Logout")
        self.api.login(self.username, password: self.password) { (response, data, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                XCTAssert(httpResponse.statusCode == 200)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
