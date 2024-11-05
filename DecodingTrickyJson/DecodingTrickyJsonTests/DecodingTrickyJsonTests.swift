//
//  DecodingTrickyJsonTests.swift
//  DecodingTrickyJsonTests
//
//  Created by Andy Brown on 24/10/2024.
//
import Foundation
import Testing
@testable import DecodingTrickyJson

let trickyJson = """
{
  "user": {
    "id": 12345,
    "name": "John Doe",
    "age": 30,
    "email": "john.doe@example.com",
    "address": {
      "street": "123 Main St",
      "city": "Anytown",
      "postalCode": "12345",
      "geo": {
        "latitude": 51.5074,
        "longitude": -0.1278
      }
    },
    "preferences": {
      "newsletter": true,
      "notifications": {
        "email": true,
        "sms": false
      }
    },
    "roles": ["admin", "user"],
    "friends": [
      {
        "id": 54321,
        "name": "Jane Smith",
        "age": null,
        "email": "jane.smith@example.com"
      },
      {
        "id": 67890,
        "name": "Jim Brown",
        "age": 25,
        "email": null
      }
    ],
    "isActive": true,
    "createdAt": "2022-04-23T18:25:43.511Z",
    "profilePictureURL": null,
    "images": {
      "small": {
        "url": "https://example.com/images/john_doe_small.jpg",
        "width": 100,
        "height": 100
      },
      "medium": {
        "url": "https://example.com/images/john_doe_medium.jpg",
        "width": 300,
        "height": 300
      },
      "large": {
        "url": "https://example.com/images/john_doe_large.jpg",
        "width": 600,
        "height": 600
      }
    }
  }
}
"""

struct DecodingTrickyJsonTests {
    
    private let decoder = JSONDecoder()
    private let jsonData: Data = {
        return trickyJson.data(using: .utf8)!
    }()

    @Test func objectCanBeDecoded() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)

        #expect(decodedUser.user != nil)
    }
    
    @Test func idIsSet() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)

        #expect(decodedUser.user.id == 12345)
    }
    
    @Test func nameIsSet() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)

        #expect(decodedUser.user.name == "John Doe")
    }
    
    @Test func addressIsSet() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)

        let address = decodedUser.user.address
        #expect(address.street == "123 Main St")
        #expect(address.postalCode == "12345")
        #expect(address.coordinates == Coordinates(lat: 51.5074, lon: -0.1278))
    }
    
    @Test func rolesAreSet() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)

        #expect(decodedUser.user.roles == [.admin, .user])
    }
    
    @Test func imagesAreSet() throws {
        let decodedUser  = try decoder.decode(UserWrapper.self, from: jsonData)
        
        #expect(decodedUser.user.images.count == 3)
        #expect(decodedUser.user.images["small"] == Image(
            url: "https://example.com/images/john_doe_small.jpg",
            width: 100,
            height: 100)
        )
        #expect(decodedUser.user.images["medium"] == Image(
            url: "https://example.com/images/john_doe_medium.jpg",
            width: 300,
            height: 300)
        )
        #expect(decodedUser.user.images["large"] == Image(
            url: "https://example.com/images/john_doe_large.jpg",
            width: 600,
            height: 600)
        )
    }
}

// MARK: - Model

struct UserWrapper: Decodable {
    let user: User
}

struct User: Decodable {
    let id: Int
    let name: String
    let address: Address
    let roles: [Roles]
    let images: [String: Image]
}

struct Address: Decodable {
    let street: String
    let postalCode: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case street, postalCode
        case coordinates = "geo"
    }
    
}

struct Coordinates: Decodable, Equatable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "latitude"
        case lon = "longitude"
    }
}

enum Roles: String, Decodable {
    case admin
    case user
}

struct Image: Decodable, Equatable {
    let url: String
    let width: Int
    let height: Int
}
