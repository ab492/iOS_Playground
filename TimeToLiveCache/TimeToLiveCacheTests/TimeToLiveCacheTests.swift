//
//  TimeToLiveCacheTests.swift
//  TimeToLiveCacheTests
//
//  Created by Andy Brown on 01/11/2024.
//

import Testing
import UIKit
@testable import TimeToLiveCache

struct TimeToLiveCacheTests {

    @Test func cachedCorrectlyReturnsIntValue() {
        @Cached(ttl: 5) var value: Int? = 5
        
        #expect(value == 5)
    }
    
    @Test func cachedCorrectlyReturnsStringValue() {
        @Cached(ttl: 5) var value: String? = "my test string"
        
        #expect(value == "my test string")
    }
    
    @Test func cachedIsInvalidatedAfterTimeToLiveHasPassed() {
        var currentTime = CACurrentMediaTime()
        @Cached(ttl: 5, currentTime: { currentTime }) var value = "my test string"
        
        currentTime += 5.1
        
        #expect(value == nil)
    }
    
    @Test func cachedIsNotInvalidatedBeforeTimeToLiveHasPassed() {
        var currentTime = CACurrentMediaTime()
        @Cached(ttl: 5, currentTime: { currentTime }) var value = "my test string"
        
        currentTime += 4.9
        
        #expect(value == "my test string")
    }

}

@propertyWrapper struct Cached<Value> {
    
    // MARK: - Types

    private struct ValueWrapper {
        let value: Value?
        let timeSet: CFTimeInterval
    }
    
    // MARK: - Properties
    
    private var backingProperty: ValueWrapper?
    private let timeToLive: Double
    private let currentTime: () -> CFTimeInterval
    
    private var cacheHasExpired: Bool {
        guard let lastSetTime = backingProperty?.timeSet else { return false }
        return currentTime() > lastSetTime + timeToLive
    }
    
    var wrappedValue: Value? {
        get {
            if cacheHasExpired {
                return nil
            } else {
                return backingProperty?.value
            }
        } set {
            backingProperty = ValueWrapper(value: newValue, timeSet: currentTime())
        }
    }

    // MARK: - Initialisers
    
    init(wrappedValue: Value, ttl: Double) {
        self.timeToLive = ttl
        self.currentTime = { CACurrentMediaTime() }
        self.wrappedValue = wrappedValue
    }
    
    init(wrappedValue: Value, ttl: Double, currentTime: @escaping () -> CFTimeInterval) {
        self.timeToLive = ttl
        self.currentTime = currentTime
        self.wrappedValue = wrappedValue
    }
}
