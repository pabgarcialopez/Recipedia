//
//  Database.swift
//  Recipedia
//
//  Created by Pablo García López on 12/11/25.
//

import FirebaseFirestore

let db = Firestore.firestore()

func updateUser(user: User, completion: ((Result<String, Error>) -> Void)? = nil) {
    
    do {
        // merge = true so that the entire user is not overwritten.
        try db.collection(USERS_COLLECTION).document(user.id).setData(from: user, merge: true) { error in
            if let error = error { completion?(.failure(error)) }
            else { completion?(.success("User updated correctly")) }
        }
    } catch {
        completion?(.failure(error))
        return
    }
}
