//
//  LabeledPicker.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//


import SwiftUI

struct LabeledPicker<Value: Hashable, Content: View>: View {
    let label: String
    @Binding var selection: Value
    let content: () -> Content
    
    init(label: String, selection: Binding<Value>, @ViewBuilder content: @escaping () -> Content) {
        self.label = label
        self._selection = selection
        self.content = content
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .foregroundStyle(.secondary)
            
            Picker("", selection: $selection, content: content)
                .pickerStyle(.menu)
                .padding(.init(top: 2, leading: 2, bottom: 2, trailing: 2))
                .background(.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.separator, lineWidth: 1)
                )
        }
    }
}

#Preview {
    @Previewable @State var difficulty: Difficulty = .medium
    LabeledPicker(label: "Difficulty", selection: $difficulty) {
        ForEach(Difficulty.allCases, id: \.self) { value in
            Text(value.description).tag(value)
        }
    }
}
