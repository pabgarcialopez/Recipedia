//
//  Database.swift
//  Recipedia
//
//  Created by Pablo García López on 12/11/25.
//

import FirebaseAuth
import FirebaseFirestore

struct DatabaseManager {
    
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
    
    static func deleteUser(user: User) {
        // Complete
    }
    
    static func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var query: Query = db.collection(RECIPES_COLLECTION)
        
        // If ownerId is provided, filter recipes
        if let ownerId = Auth.auth().currentUser?.uid {
            query = query.whereField("ownerId", isEqualTo: ownerId)
        }
        
        query.getDocuments { snapshot, error in
            DispatchQueue.main.async {
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
    
    static func updateRecipe(recipe: Recipe, completion: @escaping (Result<String, Error>) -> Void) {
        guard let recipeId = recipe.id.uuidString as String? else {
            completion(.failure(NSError(domain: "DatabaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Recipe id is missing"])))
            return
        }

        do {
            try db.collection(RECIPES_COLLECTION).document(recipeId)
                .setData(from: recipe, merge: true) { error in
                    if let error = error { completion(.failure(error)) }
                    else { completion(.success("Recipe saved successfully")) }
                }
        } catch {
            completion(.failure(error))
        }
    }
    
    static func deleteRecipe(recipe: Recipe, completion: @escaping (Result<String, Error>) -> Void) {
        
        let storagePath = "images/recipes/\(recipe.imageId).\(IMAGE_FORMAT)"
        
        StorageManager.deleteData(path: storagePath) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            db.collection(RECIPES_COLLECTION).document(recipe.id.uuidString).delete() { dbError in
                if let dbError = dbError { completion(.failure(dbError)) }
                else { completion(.success("Recipe deleted successfully")) }
            }
        }
    }

}
