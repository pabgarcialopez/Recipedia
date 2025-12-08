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
    @Published var image: Image?
    
    private static var cache = NSCache<NSString, UIImage>()
    
    func loadImage(from path: String) {
        // Check cache first
        if let cachedImage = ImageLoader.cache.object(forKey: path as NSString) {
            self.image = Image(uiImage: cachedImage)
            print("Image loaded from cache for: \(path)")
            return
        }
        
        // Download via getData
        getData(path: path) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        ImageLoader.cache.setObject(uiImage, forKey: path as NSString)
                        self.image = Image(uiImage: uiImage)
                        print("Image downloaded and cached for: \(path)")
                    }
                case .failure(let error):
                    print("Failed to load image for \(path): \(error)")
                }
            }
        }
    }
}
