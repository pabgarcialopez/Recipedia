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
    var firstName: String?
    var lastName: String?
    var bio: String?
    var pictureURL: String?
    
    init(id: String, email: String?, firstName: String? = nil, lastName: String? = nil, bio: String? = nil, pictureURL: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.bio = bio
        self.pictureURL = pictureURL
    }
}

