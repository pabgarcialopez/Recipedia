//
//  User.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Equatable {
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var bio: String
    var profilePictureId: String
    
    init(id: String, email: String, firstName: String = "", lastName: String = "", bio: String = "", profilePictureId: String = "") {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.profilePictureId = profilePictureId
        
        if self.profilePictureId.isEmpty {
            self.profilePictureId = self.id
        }
    }
    
    var fullName: String {
        guard !firstName.isEmpty || !lastName.isEmpty else { return "Unknown" }
        return (firstName + " " + lastName).trimmingCharacters(in: .whitespaces)
    }
}

extension User {
    static let empty = User(id: "", email: "email@example.com", firstName: "John", lastName: "Smith", bio: "Some bio", profilePictureId: "")
}

