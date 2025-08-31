//
//  LinksMenu.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct LinksMenu: View {
    let title: String?
    let items: [AnyView]
    
    init(_ title: String? = nil, items: [AnyView]) {
        self.title = title
        self.items = items
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = title {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 8)
            }
            
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { idx in
                    items[idx]
                    if idx < items.count - 1 { Divider() }
                }
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.separator)))
        }
        .padding(.vertical, 6)
    }
}


#Preview {
    LinksMenu("Whatever", items: [
        AnyView(Text("Hey"))
    ])
}
