//
//  LabeledTextField.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct LabeledTextField: View {
    let label: String
    let prompt: String
    let axis: Axis?
    let isSecure: Bool
    @Binding var text: String
    
    init(label: String, prompt: String, text: Binding<String>, axis: Axis? = nil, isSecure: Bool = false) {
        self.label = label
        self.prompt = prompt
        self.axis = axis
        self.isSecure = isSecure
        self._text = Binding(
            get: { text.wrappedValue },
            set: { text.wrappedValue = $0 }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .foregroundStyle(.separator)
            
            if isSecure {
                SecureField(prompt, text: $text)
            } else if let axis = axis {
                TextField(prompt, text: $text, axis: axis)
            } else {
                TextField(prompt, text: $text)
            }
        }
        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.separator, lineWidth: 1)
        )
    }
}

#Preview {
    @Previewable @State var text = "Text"
    LabeledTextField(label: "Label", prompt: "Prompt", text: $text, isSecure: true)
}
