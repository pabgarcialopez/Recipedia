//
//  ImageLoader.swift
//  Recipedia
//
//  Created by Pablo García López on 6/12/25.
//

import UIKit
import SwiftUI

// Final, persistent storage for the loaded image
typealias ImageCache = NSCache<NSString, UIImage>

class ImageLoader: ObservableObject {

    @Published var image: UIImage = UIImage(resource: .defaultPicturePlaceholder)
    @Published var isLoading: Bool = false

    private static let cache = NSCache<NSString, UIImage>()

    func loadImage(from path: String) {
        
        print("Getting picture from \(path)")

        // Cache hit -> no loading state
        if let cachedImage = Self.cache.object(forKey: path as NSString) {
            image = cachedImage
            isLoading = false
            print("Getting chached picture")
            return
        }

        isLoading = true

        StorageManager.getData(path: path) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                self.isLoading = false

                switch result {
                case .success(let data):
                    if let uiImage = UIImage(data: data) {
                        Self.cache.setObject(uiImage, forKey: path as NSString)
                        self.image = uiImage
                        print("Successfully retrieved image")
                    } else {
                        self.image = UIImage(resource: .defaultPicturePlaceholder)
                    }

                case .failure:
                    self.image = UIImage(resource: .defaultPicturePlaceholder)
                }
            }
        }
    }
}
