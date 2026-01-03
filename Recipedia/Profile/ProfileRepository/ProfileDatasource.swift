//
//  ProfileDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

final class ProfileDatasource {
    
    func updateProfilePicture(image: UIImage, imageID: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Upload image to database
        if let data = image.jpegData(compressionQuality: 0.8) {
            _ = StorageManager.uploadData(data,
                                          to: "\(PROFILE_PICTURES_PATH)/\(imageID).\(IMAGE_FORMAT)",
                                          contentType: "image/jpg",
                                          completion: completion)
        }        
    }
    
    func deleteProfilePicture(path: String, completion: @escaping (Error?) -> Void) {
        StorageManager.deleteData(path: path, completion: completion)
    }
    
    func updateUser(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        DatabaseManager.updateUser(user: user, completion: completion)
    }
}
