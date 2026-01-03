//
//  RecipeListView.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    init(recipeViewModel: RecipeViewModel) {
        self.recipeViewModel = recipeViewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipeViewModel.isLoading {
                    ProgressView()
                } else if recipeViewModel.alertStatus == .failure {
                    ContentUnavailableView("Your recipes could not be loaded", systemImage: "exclamationmark.triangle", description: Text("Please, try again later or contact support."))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else if recipeViewModel.recipes.isEmpty {
                    ContentUnavailableView("No recipes yet", systemImage: "carrot", description: Text("Add some now!"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .center, spacing: 15) { // Needed since ScrollView only provides the scrollable area, not the children arrangement.
                            ForEach(recipeViewModel.recipes, id: \.id) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe)
                                } label: {
                                    RecipeCard(recipe: recipe)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 25)
                    }
                }
            }
            .navigationTitle("My recipes")
        }
    }
}

#Preview {
    RecipeListView(recipeViewModel: RecipeViewModel())
}
