//
//  IngredientEditCard.swift
//  Recipedia
//
//  Created by Pablo García López on 28/12/25.
//

import SwiftUI

struct IngredientEditCard: View {
    
    @Binding var ingredient: Ingredient
    
    var body: some View {
        return HStack {
            Picker("", selection: $ingredient.name) {
                ForEach(IngredientName.orderedForUI) { item in
                    Text(item.displayName).tag(item)
                }
            }
            .frame(maxWidth: .infinity)
            .fixedSize()
            
            HStack(spacing: 0) {
                TextField("", value: $ingredient.quantity, format: .number, prompt: Text("Quantity"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)

                Picker("", selection: $ingredient.unit) {
                    ForEach(IngredientUnit.orderedForUI) { item in
                        Text(item.displayName).tag(item)
                    }
                }
                .fixedSize()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 5)
        .contentShape(Rectangle())
    }
    
}

#Preview {
    @Previewable @State var ingredient = Ingredient()
    
    IngredientEditCard(ingredient: $ingredient)
}
