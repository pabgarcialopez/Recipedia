//
//  RecipeRepository.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

final class RecipeRepository {
    
    private let recipeDatasource: RecipeDatasource
    
    init(recipeDatasource: RecipeDatasource = RecipeDatasource()) {
        self.recipeDatasource = recipeDatasource
    }
    
    func createRecipe(recipe: Recipe) {
        recipeDatasource.createRecipe(recipe: recipe)
    }
    
    func updateRecipe(recipe: Recipe) {
        recipeDatasource.updateRecipe(recipe: recipe)
    }
    
    func deleteRecipe(recipe: Recipe) {
        recipeDatasource.deleteRecipe(recipe: recipe)
    }

}
