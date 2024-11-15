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
    
    override init(_ name: String) {
        super.init(name)
    }
    
    @objc func testMethod() {
        wasRun = true
    }
}

class TestCaseTest: TestCase {
    @objc func testRunning() {
        let test = WasRun("testMethod")
        Assert(test.wasRun == false)
        test.run()
        Assert(test.wasRun == true)
    }
}

TestCaseTest("testRunning").run()

//let test = WasRun("testMethod")
//Assert(test.wasRun == false)
//test.run()
//Assert(test.wasRun == true)



// Invoke test method
// Invoke setUp first
// Invoke tearDown afterward
// Invoke tearDown even if the test method fails
// Run multiple tests
// Report collected results
