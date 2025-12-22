//
//  RecipeCreationView.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//

import SwiftUI

struct RecipeCreationView: View {
    
    
    var body: some View {
        VStack {
            CreationCard(
                title: "Manually add a recipe",
                description: "Enter the recipe's details manually",
                systemImage: "hammer"
            ) {
                
            }
            
            CreationCard(
                title: "AI Assist",
                description: "We’ll suggest steps and ingredients.",
                systemImage: "sparkles",
                shadowColor: .black
            ) {
                
            }
        }
    }
}

#Preview {
    RecipeCreationView()
}
