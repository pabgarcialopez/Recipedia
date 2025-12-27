//
//  RecipeEditView.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//

import SwiftUI
import PhotosUI

struct RecipeEditView: View {
    
    private let isNew: Bool
    
    // This is a draft recipe that can host a new and an already existing recipe.
    @State private var recipe: Recipe
    
    @State private var recipeImageData: Data? = nil
    @State private var selectedPicture: PhotosPickerItem? = nil
    
    @ObservedObject private var recipeViewModel: RecipeViewModel
    
    init(recipeViewModel: RecipeViewModel) { // Initializer for new recipes
        self.isNew = true
        self.recipeViewModel = recipeViewModel
        self._recipe = State(wrappedValue: Recipe())
    }
    
    init(recipe: Recipe, recipeViewModel: RecipeViewModel) {
        self.isNew = false
        self.recipeViewModel = recipeViewModel
        self._recipe = State(wrappedValue: recipe)
    }
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Create a recipe")
                    .font(.system(size: 28))
                    .bold()
                    
                photosPicker
                    
                    
            }
        }.padding(28)
    }
    
    private var photosPicker: some View {
        PhotosPicker(selection: $selectedPicture, matching: .images) {
            ZStack(alignment: .topTrailing) {
                Group {
                    if let data = self.recipeImageData,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        ContentUnavailableView(
                            "Upload image",
                            systemImage: "fork.knife.circle",
                            description: Text("Better in landscape orientation")
                        )
                        .background(Color.secondary.opacity(0.2))
                    }
                }
                .frame(maxHeight: 170)
                .clipShape(RoundedRectangle(cornerRadius: 15))

                if self.recipeImageData != nil {
                    Button(action: unsetRecipeImageData) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 28, height: 28)
                            .overlay(
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            )
                            .padding(10)
                    }
                }
            }

        }
        .onChange(of: selectedPicture) { setRecipeImageData(from: selectedPicture) }
    }
    
    private func setRecipeImageData(from selectedPicture: PhotosPickerItem?) {
        
        Task {
            if let data = try? await selectedPicture?.loadTransferable(type: Data.self) {
                self.recipeImageData = data
                recipeViewModel.setRecipeImageData(from: data)
            } else {
                // TODO: handle the error here better.
                print("Data from selected picture could not be loaded correctly")
            }
        }
    }
    
    private func unsetRecipeImageData() {
        self.recipeImageData = nil
        self.selectedPicture = nil
    }
    
    
}

#Preview {
    RecipeEditView(recipeViewModel: RecipeViewModel())
}
