//
//  RecipeViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    private let recipeRepository: RecipeRepository
    
    init(recipeRepository: RecipeRepository = RecipeRepository()) {
        self.recipeRepository = recipeRepository
    }
    
    func createRecipe(recipe: Recipe) {
        self.recipeRepository.createRecipe(recipe: recipe)
    }
    
    func updateRecipe(recipe: Recipe) {
        self.recipeRepository.updateRecipe(recipe: recipe)
    }
    
    func deleteRecipe(recipe: Recipe) {
        self.recipeRepository.deleteRecipe(recipe: recipe)
    }
}
