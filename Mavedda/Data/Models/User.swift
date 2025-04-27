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
    let name: String?

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.email == rhs.email
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
    }
}
