//
//  LabeledStepper.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//

import SwiftUI

struct LabeledStepper: View {
    let label: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    init(label: String, value: Binding<Int>, range: ClosedRange<Int>) {
        self.label = label
        self._value = value
        self.range = range
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(label)
                .foregroundStyle(.secondary)
            
            HStack {
                Button {
                    value = max(range.lowerBound, value - 1)
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 30, height: 30)
                        .contentShape(Rectangle())
                }

                Text("\(value)")
                    .frame(minWidth: 40)

                Button {
                    value = min(range.upperBound, value + 1)
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .contentShape(Rectangle())
                }
            }
            .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.separator, lineWidth: 1)
            )
        }
    }
}

#Preview {
    @Previewable @State var numPeople = 4
    LabeledStepper(label: "Number of people", value: $numPeople, range: 1...10)
}
