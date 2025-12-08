//
//  ProfileDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

final class ProfileDatasource {
    
    let storageRef = Storage.storage().reference()
    let db = Firestore.firestore()
    
    func fetchProfilePicture(for user: User, completion: @escaping (UIImage) -> Void) {
        guard !user.pictureURL.isEmpty else {
            completion(UIImage(resource: .defaultProfilePicture))
            return
        }
        
        let path = "images/profilePictures/\(user.pictureURL)"
        
        getData(path: path) { result in
            switch result {
            case .success(let data):
                if let data = data, let uiImage = UIImage(data: data) {
                    completion(uiImage)
                } else {
                    completion(UIImage(resource: .defaultProfilePicture))
                }
            case .failure(_):
                completion(UIImage(resource: .defaultProfilePicture))
            }
        }
    }

    
    func updateProfilePicture(image: UIImage, imageID: String, completion: @escaping (Result<String, Error>) -> Void) -> String {
        // Upload image to database
        if let data = image.jpegData(compressionQuality: 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            _ = uploadData(data, to: "images/profilePictures/\(imageID)", metadata: metadata, completion: completion)
        }
        
        return imageID
    }
    
    func deleteProfilePicture(path: String, completion: @escaping (Error?) -> Void) {
        deleteData(path: path, completion: completion)
    }
    
    // TODO: delegate to new Database file
    func updateUser(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        
        do {
            // merge = true so that the entire user is not overwritten.
            try db.collection(USERS_COLLECTION).document(user.id).setData(from: user, merge: true) { error in
                if let error = error { completion(.failure(error)) }
                else { completion(.success("User updated correctly")) }
            }
        } catch {
            completion(.failure(error))
            return
        }
    }
}
