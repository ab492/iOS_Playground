//
//  SearchViewModelTests.swift
//  SearchViewModelTests
//
//  Created by Andy Brown on 11/11/2024.
//

//import Testing
import XCTest
import UIKit
@testable import SearchViewModel

class SearchViewModelTests: XCTestCase {

    func test_whenSearchingForString_networkRequestIsFiredAfterGivenTime() {
        let spyNetworkService = SpyNetworkService()
        let sut = SearchViewModel(searchApiService: spyNetworkService, searchDebounce: 0.2)
       
        sut.search(for: "My test string")
        
        // verify network request hasn't sent
        XCTAssertEqual(spyNetworkService.callCount, 0)

        // wait 0.2 seconds
        let expectation = XCTestExpectation(description: "Search result fired after some delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.25)
        
        // verify network request has sent
        XCTAssertEqual(spyNetworkService.callCount, 1)
    }
}

protocol NetworkService {
    
}

class SpyNetworkService: NetworkService {
    var callCount = 0
}

struct SearchViewModel {
    let searchApiService: NetworkService
    let searchDebounce: Double
    
    func search(for searchTerm: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + searchDebounce) {
//            searchApiService.search(for: searchTerm)
        }
    }
}

// When searching for a string, network request is fired only after given time
// When search for a string, previous request is cancelled if in progress
