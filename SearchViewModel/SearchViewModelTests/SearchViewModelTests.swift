////
////  SearchViewModelTests.swift
////  SearchViewModelTests
////
////  Created by Andy Brown on 11/11/2024.
////
//
////import Testing
//import XCTest
//import UIKit
//@testable import SearchViewModel
//
//class SearchViewModelTests: XCTestCase {
//
//    func test_whenSearchingForString_networkRequestIsFiredAfterGivenTime() async throws {
//        let spyNetworkService = SpyUrlSession()
//        let sut = SearchViewModel(searchApiService: spyNetworkService, searchDebounce: 0.2)
//        sut.search(for: "My test string")
//        XCTAssertEqual(spyNetworkService.dataTaskCallCount, 0, "The request should not have fired immediately")
//
//        // Wait for debounce time to elapse
//        let delay = UInt64(0.21 * 1_000_000_000)
//        try await Task.sleep(nanoseconds: delay)
//
//        XCTAssertEqual(spyNetworkService.dataTaskCallCount, 1)
//    }
//}
//
//protocol URLSessionProtocol {
//    func data(for request: URLRequest) async throws -> (Data, URLResponse)
//}
//
//struct SearchViewModel {
//    
//    let urlSession: URLSessionProtocol
//    let searchDebounce: Double
//    
//    init(searchApiService:  URLSessionProtocol = URLSession.shared, searchDebounce: Double) {
//        self.urlSession = searchApiService
//        self.searchDebounce = searchDebounce
//    }
//    
//    func search(for searchTerm: String) {
//        Task {
//            try? await Task.sleep(nanoseconds: UInt64(searchDebounce * 1_000_000_000))
//            
//            guard let url = URL(string: "https://www.my-search-service/\(searchTerm)") else {
//                print("Invalid URL")
//                return
//            }
//            
//            let request = URLRequest(url: url)
//            do {
//                let (_, _) = try await urlSession.data(for: request)
//            } catch {
//                print("Request failed with error: \(error)")
//            }
//        }
//    }
//}
//
//extension URLSession: URLSessionProtocol { }
//
//class SpyUrlSession: URLSessionProtocol {
//    var dataTaskCallCount = 0
//    var lastSentRequest: URLRequest?
//    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
//        dataTaskCallCount += 1
//        lastSentRequest = request
//        return (Data(), URLResponse())
//    }
//}
//
//
////
////    func test_whenSearchingForString_urlRequestContainsCorrectInfo() async {
////        let spyNetworkService = SpyUrlSession()
////        let sut = SearchViewModel(searchApiService: spyNetworkService, searchDebounce: 0.2)
////
////        sut.search(for: "My test string")
////
////        // Wait for debounce time to elapse
////        let delay = UInt64(0.21 * 1_000_000_000)
////        try? await Task.sleep(nanoseconds: delay)
////
////        XCTAssertEqual(spyNetworkService.lastSentRequest!.url, URL(string: "https://www.my-search-service/My%20test%20string"))
////    }
//
//// When searching for a string, network request is fired only after given time ✅
//// When search for a string, network request contains correct string
//// When search for a string, previous request is cancelled if in progress
//
//
//// Would it be better to use async await?
