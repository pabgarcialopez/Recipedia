//
//  ProfileViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

import SwiftUI
import FirebaseStorage

final class ProfileViewModel: ObservableObject {

    @Published var user: User
    @Published var profilePicture: Image
    
    private let profileRepository: ProfileRepository
    private let authenticationViewModel: AuthenticationViewModel
    
    init(profileRepository: ProfileRepository = ProfileRepository(), authenticationViewModel: AuthenticationViewModel) {
        
        self.user = .empty
        self.profilePicture = Image(DEFAULT_PROFILE_PICTURE)
        self.profileRepository = profileRepository
        self.authenticationViewModel = authenticationViewModel
        
        // Try to fetch profile picture from database
        fetchUser()
        fetchProfilePicture()
    }
    
    func fetchUser() {
        self.user = authenticationViewModel.user ?? .empty
    }
    
    func fetchProfilePicture() {
        profileRepository.fetchProfilePicture(for: self.user) { [weak self] image in
            self?.profilePicture = image
        }
    }
    
    func signOut() {
        authenticationViewModel.signOut()
    }
}
