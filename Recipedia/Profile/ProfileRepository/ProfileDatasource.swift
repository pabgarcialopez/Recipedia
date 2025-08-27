//
//  ProfileDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI
import FirebaseStorage

final class ProfileDatasource {
    
    func fetchProfilePicture(for user: User, completion: @escaping (Image) -> Void) {
        guard let pictureURL = user.pictureURL else {
            print("Here!!!")
            completion(Image(DEFAULT_PROFILE_PICTURE))
            return
        }
        
        print("profilePicture URL: \(pictureURL)")

        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/profilePictures/\(pictureURL)")

        imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let data = data, let uiImage = UIImage(data: data) {
                completion(Image(uiImage: uiImage))
            } else {
                completion(Image(DEFAULT_PROFILE_PICTURE))
            }
        }
    }
}
