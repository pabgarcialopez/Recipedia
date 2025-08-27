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
    
    func fetchProfilePicture(for user: User, completion: @escaping (Image) -> Void) {
        profileDatasource.fetchProfilePicture(for: user, completion: completion)
    }
}
