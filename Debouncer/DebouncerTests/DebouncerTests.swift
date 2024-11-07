//
//  DebouncerTests.swift
//  DebouncerTests
//
//  Created by Andy Brown on 05/11/2024.
//

import Testing

struct DebouncerTests {

    @Test func test_creatingDebouncer()  {
        let sut = Debouncer(time: 0.2)
        
        var closureWasCalled = false
        sut.perform {
            closureWasCalled = true
        }
        
        #expect(closureWasCalled == true)
    }
}

// https://www.donnywals.com/testing-completion-handler-apis-with-swift-testing/

struct Debouncer {
    init(time: Double) {}
    
//    func perform(_ closure: () -> Void) {
//        
//    }
}

// Write the tests I want first!

// When closure is added to debouncer, it is triggered after specified time.
// When another closure is added to debouncer, the existing work is cancelled.
