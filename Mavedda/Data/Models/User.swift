//
//  User.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

struct User: Identifiable, Equatable, Decodable {
    let id: String
    let email: String
    let name: String?  // Name is now optional in case it's missing from the API response

    // Implement the Equatable conformance to compare two User objects
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.email == rhs.email
    }
    
    // CodingKeys is used to map the struct properties to the API response
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
    }
}
