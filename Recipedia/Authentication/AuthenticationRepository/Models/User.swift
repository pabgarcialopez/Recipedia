//
//  User.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import Foundation
import FirebaseFirestore

// Conform
struct User: Codable, Equatable {
    let id: String
    var email: String
    var firstName: String = ""
    var lastName: String = ""
    var bio: String = ""
    var pictureURL: String? = nil
    
    var fullName: String {
        guard !firstName.isEmpty || !lastName.isEmpty else { return "Unknown" }
        return (firstName + " " + lastName).trimmingCharacters(in: .whitespaces)
    }
}

extension User {
    static let empty = User(id: "", email: "email@example.com", firstName: "John", lastName: "Smith", bio: "Some bio", pictureURL: "")
}

