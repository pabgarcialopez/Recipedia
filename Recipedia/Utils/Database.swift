//
//  Database.swift
//  Recipedia
//
//  Created by Pablo García López on 12/11/25.
//

import FirebaseFirestore

struct Database {
    
    static let db = Firestore.firestore()
    
    static func updateUser(user: User, completion: ((Result<String, Error>) -> Void)? = nil) {
        
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
    
    
    static func fetchRecipes(completion: @escaping (Result<[Recipe], any Error>) -> Void) {
        db.collection(RECIPES_COLLECTION).getDocuments { snapshot, error in
            DispatchQueue.main.async {  // ensures safe UI updates
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                do {
                    let recipes = try documents.map { try $0.data(as: Recipe.self) }
                    completion(.success(recipes))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
