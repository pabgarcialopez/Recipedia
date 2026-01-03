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
    @Published var isLoading: Bool = false
    @Published var alertTitle: String? = nil
    @Published var alertMessage: String? = nil
    @Published var alertStatus: CompletionStatus? = nil
    
    @Published var uploadProgress: Double = 0.0
    @Published var isUploadingImage: Bool = false
    
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
                    self.recipes = recipes
                    self.alertStatus = .success
                case .failure(let error):
                print("Error when loading the recipes: \(error.localizedDescription)")
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.alertStatus = .failure
                }
            self.isLoading = false
        }
    }
    
    // Creates and updates a recipe
    func updateRecipe(recipe: Recipe) {
        self.isLoading = true
        self.recipeRepository.updateRecipe(recipe: recipe) { result in
            self.isLoading = false
            switch result {
                case .success(_):
                    self.recipes.append(recipe) // To update Home View.
                    self.alertTitle = "Success"
                    self.alertMessage = "Your recipe has been saved!"
                    self.alertStatus = .success
                case .failure(let error):
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.alertStatus = .failure
            }
        }
    }
    
    func deleteRecipe(recipe: Recipe) {
        self.isLoading = true
        self.recipeRepository.deleteRecipe(recipe: recipe) { result in
            self.isLoading = false
            switch result {
                case .success(_):
                    self.alertTitle = "Success"
                    self.alertMessage = "Your recipe has been deleted!"
                    self.alertStatus = .success
                case .failure(let error):
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.alertStatus = .failure
            }
        }
    }
    
    func saveRecipe(recipe: Recipe, recipeImageData: Data?) {
        self.isLoading = true
        
        // 1. If there's an image, upload it first and track progress
        if let data = recipeImageData {
            self.isUploadingImage = true
            self.uploadProgress = 0.0
            
            recipeRepository.saveRecipeImage(from: data, imageId: recipe.imageId) { progress in
                // Update progress bar UI
                self.uploadProgress = progress
            } completion: { result in
                self.isUploadingImage = false
                // 2. Once image is done, save the recipe metadata
                self.updateRecipe(recipe: recipe)
            }
        } else {
            // No image? Just save the metadata
            self.updateRecipe(recipe: recipe)
        }
    }
}
