//
//  main.swift
//  SwiftXUnit
//
//  Created by Andy Brown on 15/11/2024.
//

import Foundation

class WasRun {
    var wasRun = false
    
    init(_ method: String) {
        
    }
    
    func testMethod() {
        wasRun = true
    }
    
    func run() {
        testMethod()
    }
    
}

let test = WasRun("testMethod")
print(test.wasRun)
test.run()
print(test.wasRun)



// Invoke test method
// Invoke setUp first
// Invoke tearDown afterward
// Invoke tearDown even if the test method fails
// Run multiple tests
// Report collected results
