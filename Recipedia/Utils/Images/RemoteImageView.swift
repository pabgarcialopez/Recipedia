//
//  RemoteImageView.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import Foundation
import SwiftUI

struct RemoteImageView: View {
    
    @Environment(\.imageLoader) private var loader

    private let urlString: String
    private let size: CGFloat = 80
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var body: some View {
        Group {
            // Success: display image
            if let image = loader.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipped()
            } else {
                // Failure: show placeholder
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: size, height: size)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
        }
        .onAppear {
            // Start the loading process only when the view is visible
            loader.loadImage(from: urlString)
        }
    }
}
