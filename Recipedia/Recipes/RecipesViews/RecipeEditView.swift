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
    
    // Initializer for new recipes
    init(recipeViewModel: RecipeViewModel) {
        self.isNew = true
        self.recipeViewModel = recipeViewModel
        self._recipe = State(wrappedValue: Recipe())
    }
    
    // Initializer for an existing recipe
    init(recipe: Recipe, recipeViewModel: RecipeViewModel) {
        self.isNew = false
        self.recipeViewModel = recipeViewModel
        self._recipe = State(wrappedValue: recipe)
    }
    
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 20) {
                    Text(self.isNew ? "New recipe" : "Edit recipe")
                        .font(.system(size: 28))
                        .bold()
                    
                    photosPicker
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Basic info")
                            .font(.system(size: 18))
                            .bold()
                        LabeledTextField(label: "Title", prompt: "Recipe's name", text: $recipe.name)
                        LabeledTextField(label: "Description", prompt: "Brief recipe description", text: $recipe.description, axis: .vertical)
                        LabeledTextField(label: "Time (mins)", prompt: "Time", text: $recipe.time)
                        
                        HStack {
                            LabeledStepper(label: "# of people", value: $recipe.numPeople, range: 1...16)
                            Spacer()
                            LabeledPicker(label: "Difficulty", selection: $recipe.difficulty, content: {
                                ForEach(Difficulty.allCases, id: \.self) { difficulty in Text(difficulty.description)}
                            })
                            Spacer()
                            LabeledPicker(label: "Cost", selection: $recipe.cost, content: {
                                ForEach(Cost.allCases, id: \.self) { cost in Text(cost.description)}
                            })
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.system(size: 18))
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach($recipe.ingredients) { $ingredient in
                                IngredientEditCard(ingredient: $ingredient)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            deleteIngredient(ingredient)
                                        } label: {
                                            Label("Delete ingredient", systemImage: "trash")
                                        }
                                    }
                                Divider()
                            }
                            
                            Button(action: addIngredient) {
                                HStack(spacing: 13) {
                                    Image(systemName: "plus")
                                        .clipShape(Circle())
                                    Text("Add ingredient")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            
                            
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.separator))
                        )
                    }
                }
            }
            .padding(28)
        }
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
                        .frame(height: 170)
                        .padding(.top, 20)
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
    
    private func addIngredient() {
        recipe.ingredients.append(Ingredient())
    }
    
    private func deleteIngredient(_ ingredient: Ingredient) {
        if let index = recipe.ingredients.firstIndex(where: {$0.id == ingredient.id} ) {
            recipe.ingredients.remove(at: index)
        }
    }
    
}

#Preview {
    RecipeEditView(recipeViewModel: RecipeViewModel())
}
