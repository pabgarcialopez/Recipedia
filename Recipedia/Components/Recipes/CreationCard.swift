//
//  CreationCard.swift
//  Recipedia
//
//  Created by Pablo García López on 22/12/25.
//

import SwiftUI

struct CreationCard<Destination: View>: View {
    let title: String
    let description: String
    let systemImage: String
    let shadowColor: Color
    let destination: Destination

    init(
        title: String,
        description: String,
        systemImage: String,
        shadowColor: Color = .black,
        @ViewBuilder destination: () -> Destination
    ) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
        self.shadowColor = shadowColor
        self.destination = destination()
    }

    var body: some View {
        NavigationLink {
            destination
        } label: {
            ZStack {
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray6))
                            .frame(width: 36, height: 36)
                        Image(systemName: systemImage)
                            .foregroundStyle(.primary)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // <- make the card stretch
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: shadowColor.opacity(0.12), radius: 8, x: 0, y: 4)
                .contentShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

#Preview {
    NavigationStack {
        VStack(spacing: 16) {
            CreationCard(
                title: "AI Assist",
                description: "We’ll suggest steps and ingredients.",
                systemImage: "sparkles",
                shadowColor: .black
            ) {
                Text("Destination View")
                    .navigationTitle("AI Assist")
            }
        }
        .padding()
    }
}

