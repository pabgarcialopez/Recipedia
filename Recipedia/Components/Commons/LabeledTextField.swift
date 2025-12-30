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
    let disabled: Bool
    let lowercase: Bool

    @Binding var text: String

    init(
        label: String,
        prompt: String,
        text: Binding<String>,
        axis: Axis? = nil,
        isSecure: Bool = false,
        disabled: Bool = false,
        lowercase: Bool = false
    ) {
        self.label = label
        self.prompt = prompt
        self.axis = axis
        self.isSecure = isSecure
        self.disabled = disabled
        self.lowercase = lowercase

        self._text = Binding(
            get: { text.wrappedValue },
            set: { newValue in
                text.wrappedValue = lowercase
                    ? newValue.lowercased()
                    : newValue
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .foregroundStyle(.secondary)

            Group {
                if isSecure {
                    SecureField(prompt, text: $text)
                } else if let axis = axis {
                    TextField(prompt, text: $text, axis: axis)
                } else {
                    TextField(prompt, text: $text)
                }
            }
            .disabled(disabled)
            .autocapitalization(lowercase ? .none : .sentences)
        }
        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.separator, lineWidth: 1)
        )
    }
}

#Preview {
    @Previewable @State var text = "text"

    LabeledTextField(
        label: "Label",
        prompt: "Prompt",
        text: $text,
        lowercase: true
    )
}

