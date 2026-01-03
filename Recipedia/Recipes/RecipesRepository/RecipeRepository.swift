//
//  RecipeRepository.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

final class RecipeRepository {
    
    private let recipeDatasource: RecipeDatasource
    
    init(recipeDatasource: RecipeDatasource = RecipeDatasource()) {
        self.recipeDatasource = recipeDatasource
    }
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], any Error>) -> Void) {
        recipeDatasource.fetchRecipes(completion: completion)
    }
    
    func updateRecipe(recipe: Recipe, completion: @escaping (Result<String, any Error>) -> Void) {
        recipeDatasource.updateRecipe(recipe: recipe, completion: completion)
    }
    
    func deleteRecipe(recipe: Recipe, completion: @escaping (Result<String, any Error>) -> Void) {
        recipeDatasource.deleteRecipe(recipe: recipe, completion: completion)
    }
    
    func saveRecipeImage(from data: Data?, imageId: String, progress: @escaping (Double) -> Void, completion: @escaping (Result<Void, Error>) -> Void) {
        recipeDatasource.saveRecipeImage(from: data, imageId: imageId, progress: progress, completion: completion)
    }

}
