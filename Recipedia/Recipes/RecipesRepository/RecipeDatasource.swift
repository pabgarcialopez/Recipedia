//
//  RecipeDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

final class RecipeDatasource {
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], any Error>) -> Void) {
        Database.fetchRecipes(completion: completion)
    }
    
    func createRecipe(recipe: Recipe) {
        
    }
    
    func updateRecipe(recipe: Recipe) {
        
    }
    
    func deleteRecipe(recipe: Recipe) {
        
    }
}
