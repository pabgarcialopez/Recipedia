//
//  RecipeDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

final class RecipeDatasource {
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], any Error>) -> Void) {
        DatabaseManager.fetchRecipes(completion: completion)
    }
    
    func updateRecipe(recipe: Recipe, completion: @escaping (Result<String, any Error>) -> Void) {
        DatabaseManager.updateRecipe(recipe: recipe, completion: completion)
    }
    
    func deleteRecipe(recipe: Recipe, completion: @escaping (Result<String, any Error>) -> Void) {
        DatabaseManager.deleteRecipe(recipe: recipe, completion: completion)
    }
    
    func saveRecipeImage(from data: Data?, imageId: String, progress: @escaping (Double) -> Void, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let data = data else { return }
        let path = "\(RECIPES_PICTURES_PATH)/\(imageId).\(IMAGE_FORMAT)"
        
        // Assuming StorageManager.uploadData returns the StorageUploadTask
        let task = StorageManager.uploadData(data, to: path, contentType: "image/jpg")
        
        task.observe(.progress) { snapshot in
            let percentComplete = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            progress(percentComplete)
        }
        
        task.observe(.success) { _ in
            completion(.success(()))
        }
        
        task.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(.failure(error))
            }
        }
    }
}
