//
//  RecipeViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation

@MainActor // To make all properties and methods run on main thread (good for UI udpdates)
final class RecipeViewModel: ObservableObject {
    
    private let recipeRepository: RecipeRepository
    
    @Published var recipes: [Recipe]
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init(recipeRepository: RecipeRepository = RecipeRepository()) {
        self.recipeRepository = recipeRepository
        self.recipes = []
        
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        self.isLoading = true
        recipeRepository.fetchRecipes { result in
            switch result {
            case .success(let recipes):
                print("I got here and recipes are \(recipes)")
                self.recipes = recipes
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
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
    
    func setRecipeImageData(from data: Data) {

    }
}
