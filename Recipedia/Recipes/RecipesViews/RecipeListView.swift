//
//  RecipeListView.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

struct RecipeListView: View {
    
    private let recipeViewModel: RecipeViewModel
    
    init(recipeViewModel: RecipeViewModel = RecipeViewModel()) {
        self.recipeViewModel = recipeViewModel
    }
    
    var body: some View {
        if recipeViewModel.recipes.isEmpty {
            ContentUnavailableView("No recipes yet", systemImage: "carrot", description: Text("Add some now!"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                VStack(alignment: .center, spacing: 30) { // Needed since ScrollView only provides the scrollable area, not the children arrangement.
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
}

#Preview {
    RecipeListView()
}
