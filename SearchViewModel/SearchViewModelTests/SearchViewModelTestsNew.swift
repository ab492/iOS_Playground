//
//  SearchViewModelTestsNew.swift
//  SearchViewModelTests
//
//  Created by Andy Brown on 15/11/2024.
//

import Testing
import Clocks
import Foundation
struct SearchViewModelTestsNew {

    @Test func whenSearchingForString_networkRequestIsFiredAfter200MsDebounce() async throws {
        let spyNetworkService = SpyUrlSession()
        let clock = TestClock()
        let sut = SearchViewModel(searchApiService: spyNetworkService, clock: clock)
        sut.search(for: "My test string")
        #expect(spyNetworkService.dataTaskCallCount == 0, "The request should not have fired immediately")
        
        await clock.advance(by: .milliseconds(200))
        
        #expect(spyNetworkService.dataTaskCallCount == 1)
    }

}

struct SearchViewModel {

    let urlSession: URLSessionProtocol
    let clock: any Clock<Duration>

    init(searchApiService:  URLSessionProtocol = URLSession.shared, clock: any Clock<Duration>) {
        self.urlSession = searchApiService
        self.clock = clock
    }

    func search(for searchTerm: String) {
        Task {
            try await self.clock.sleep(for: .milliseconds(200))

            guard let url = URL(string: "https://www.my-search-service/\(searchTerm)") else {
                print("Invalid URL")
                return
            }

            let request = URLRequest(url: url)
            do {
                let (_, _) = try await urlSession.data(for: request)
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

class SpyUrlSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var lastSentRequest: URLRequest?
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataTaskCallCount += 1
        lastSentRequest = request
        return (Data(), URLResponse())
    }
}
