//
//  ProfileRepository.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

final class ProfileRepository {
    
    private let profileDatasource: ProfileDatasource
    
    init(profileDatasource: ProfileDatasource = ProfileDatasource()) {
        self.profileDatasource = profileDatasource
    }
    
    func updateUser(user: User, completion: @escaping (Result<String, Error>) -> Void) {
        profileDatasource.updateUser(user: user, completion: completion)
    }
    
    func updateProfilePicture(image: UIImage, imageID: String, completion: @escaping (Result<String, Error>) -> Void) -> String {
        return profileDatasource.updateProfilePicture(image: image, imageID: imageID, completion: completion)
    }
    
    func deleteProfilePicture(path: String, completion: @escaping (Error?) -> Void) {
        profileDatasource.deleteProfilePicture(path: path, completion: completion)
    }
    
    func fetchProfilePicture(for user: User, completion: @escaping (UIImage) -> Void) {
        profileDatasource.fetchProfilePicture(for: user, completion: completion)
    }
}
