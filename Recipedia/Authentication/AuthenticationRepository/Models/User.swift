//
//  User.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
    let id: String
    let email: String?
    var firstName: String? = nil
    var lastName: String? = nil
    var bio: String? = nil
    var pictureURL: String? = nil
    
    var fullName: String {
        guard let firstName = firstName, let lastName = lastName else { return "" }
        return firstName + " " + lastName
    }
}

extension User {
    static let empty = User(id: "", email: "", firstName: "", lastName: "", bio: "", pictureURL: "")
}

