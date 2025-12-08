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
        Text("Hello")
    }
}

#Preview {
    RecipeListView()
}
