//
//  RecipeCreationView.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//

import SwiftUI

struct RecipeCreationView: View {
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                CreationCard(
                    title: "Manually add a recipe",
                    description: "Enter the recipe's details manually.",
                    systemImage: "hammer"
                ) { RecipeEditView(recipeViewModel: recipeViewModel) }
                
                CreationCard(
                    title: "AI Assist",
                    description: "Let AI create a new recipe for you.",
                    systemImage: "sparkles",
                ) {
                    // TODO: create view for AI
                }
            }
            .padding(.init(top: 0, leading: 30, bottom: 0, trailing: 30))
        }
    }
}

#Preview {
    RecipeCreationView(recipeViewModel: RecipeViewModel())
}
