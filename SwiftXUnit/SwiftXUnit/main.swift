//
//  main.swift
//  SwiftXUnit
//
//  Created by Andy Brown on 15/11/2024.
//

import Foundation

public func Assert(_ condition: @autoclosure () -> Bool, message: String = "") {
    if condition() {
        print("✅ Assertion passed")
    } else {
        print("❌ Assertion failed: \(message)")
    }
}

class TestCase: NSObject {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func run() {
        let selector = Selector(name)
        if responds(to: selector) {
            perform(selector)
        } else {
            print("Method \(name) does not exist")
        }
    }
}

class WasRun: TestCase {
    var wasRun = false
    var wasSetup = false
    
    override init(_ name: String) {
        super.init(name)
    }
    
    @objc func testMethod() {
        setUp()
        wasRun = true
    }
    
    func setUp() {
        wasRun = false
        wasSetup = true
    }
}

class TestCaseTest: TestCase {
    @objc func testRunning() {
        let test = WasRun("testMethod")
        test.run()
        Assert(test.wasRun == true)
    }
    
    @objc func testSetUp() {
        let test = WasRun("testMethod")
        test.run()
        Assert(test.wasSetup == true)
    }
}

TestCaseTest("testRunning").run()
TestCaseTest("testSetUp").run()




// Invoke test method ✅
// Invoke setUp first
// Invoke tearDown afterward
// Invoke tearDown even if the test method fails
// Run multiple tests
// Report collected results
