//
//  socialFBTests.swift
//  socialFBTests
//
//  Created by Kashif Mehmood on 27/09/2018.
//  Copyright © 2018 Kashif. All rights reserved.
//

import XCTest

class socialFBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        guard let gitUrl = URL(string: "https://api.github.com/users/123abcdefghi") else { return }
        let promise = expectation(description: "Status code is 404 which means webpage not available")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
             let httpResponse = response as! HTTPURLResponse
             XCTAssert(httpResponse.statusCode == 404)
                promise.fulfill()
            }.resume()
        waitForExpectations(timeout: 1000, handler: nil)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
       // self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

