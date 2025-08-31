//
//  ProfileNavigationLink.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct ProfileNavigationLink<Destination: View>: View {
    let title: String
    let icon: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .padding(8)
                    .background(Color(UIColor.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 30)
                Text(title)
                    .padding(.leading, 5)
                Spacer()
                Image(systemName: "chevron.forward")
                    .padding(.trailing, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.black)
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    ProfileNavigationLink(title: "Hello", icon: "person.fill", destination: EmptyView())
}
