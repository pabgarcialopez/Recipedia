//
//  RecipeCard.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import SwiftUI

struct RecipeCard: View {
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            // Picture
//            RemoteImageView(path: String)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3)) // Placeholder background
                .frame(width: 130, height: 100)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(2) // Keep the name concise
                
                // Recipe time
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(.secondary)
                    Text("\(recipe.time) min")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                // Recipe difficulty
                HStack(spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundStyle(.secondary)
                    
                    if let difficulty = recipe.difficulty {
                        Text(difficulty.description)
                            .foregroundColor(difficulty.color)
                    } else {
                        Text("Unknown difficulty")
                            .foregroundColor(.secondary)
                    }
                }
                .font(.subheadline)
            }
            Spacer() // Push VStack content to the left
        }
        .padding(10) // Small padding inside the card borders
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 2)
        .padding(.horizontal) // To separate card from screen edges
    }
}


#Preview {
    RecipeCard(recipe: Recipe(
        // Assuming you have Step, Cost, and Difficulty defined elsewhere
        
        name: "Spicy Coconut Curry with many ingredients!",
        description: "A quick, vibrant, and creamy vegan curry with a kick.",
        cost: .cheap,
        time: 35,
        difficulty: .easy,
        numPeople: 4,
        steps: [
            Step(
                title: "Prep",
                instruction: "Finely chop the garlic and gather all measured ingredients."
            ),
            Step(
                title: "Sauté",
                instruction: "Heat a large pot over medium heat, add the chopped garlic and red curry paste, and sauté for 2 minutes until fragrant."
            ),
            Step(
                title: "Simmer",
                instruction: "Pour in the coconut milk and vegetable broth. Bring the mixture to a gentle simmer for 15 minutes."
            ),
            Step(
                title: "Serve",
                instruction: "Serve immediately over cooked Basmati rice and squeeze fresh lime juice on top."
            ),
        ],
        ingredients: [
            // Example 1: Mass/Weight (grams)
            Ingredient(name: "Basmati Rice", quantity: 250, unit: .grams),
            
            // Example 2: Volume (milliliters)
            Ingredient(name: "Coconut Milk", quantity: 400, unit: .milliliters),
            
            // Example 3: Count (units)
            Ingredient(name: "Garlic Cloves", quantity: 3, unit: .units),
            
            // Example 4: Cooking Measure (tablespoon)
            Ingredient(name: "Red Curry Paste", quantity: 2, unit: .tablespoon),
            
            // Example 5: Volume (cups)
            Ingredient(name: "Vegetable Broth", quantity: 1.5, unit: .cups),
            
            // Example 6: Count (pieces/slices)
            Ingredient(name: "Lime", quantity: 4, unit: .slice)
        ],
        
        imageId: "https://example.com/images/coconut_curry.jpg"
    ))
}
