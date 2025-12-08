//
//  RecipeViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    
    private let recipeRepository: RecipeRepository
    
    @Published var recipes: [Recipe]
    @Published var errorMessage: String? = nil
    
    init(recipeRepository: RecipeRepository = RecipeRepository()) {
        self.recipeRepository = recipeRepository
        self.recipes = []
        
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        self.recipeRepository.fetchRecipes { result in
            switch result {
                case .success(let recipes):
                    self.recipes = recipes
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
            
        }
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
