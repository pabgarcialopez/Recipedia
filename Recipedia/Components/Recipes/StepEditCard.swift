//
//  IngredientEditCard.swift
//  Recipedia
//
//  Created by Pablo García López on 28/12/25.
//

import SwiftUI

struct StepEditCard: View {
    
    let order: Int
    @Binding var step: Step
    
    var body: some View {
        return HStack {
            
            Text("\(order)")
                .frame(width: 28, height: 28)
                .padding(.horizontal, 10)
                .font(.body.bold())
                .clipShape(Circle())
                .overlay(Circle().stroke(.black, lineWidth: 2))
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("Title", text: $step.title)
                    .font(.body.bold())
                TextField("Instruction", text: $step.instruction, axis: .vertical)
                    .font(.body)
            }
        }
        .padding(12)
        .contentShape(Rectangle())
    }
    
}

#Preview {
    @Previewable @State var ingredient = Ingredient()
    
    IngredientEditCard(ingredient: $ingredient)
}
