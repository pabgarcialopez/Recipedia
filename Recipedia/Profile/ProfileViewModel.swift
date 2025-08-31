//
//  ProfileViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

import SwiftUI
import PhotosUI
import FirebaseStorage

final class ProfileViewModel: ObservableObject {

    @Published var user: User
    @Published var profilePicture: UIImage = UIImage(resource: .defaultProfilePicture)
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    
    private let profileRepository: ProfileRepository
    private let authenticationViewModel: AuthenticationViewModel
    
    init(profileRepository: ProfileRepository = ProfileRepository(), authenticationViewModel: AuthenticationViewModel) {
        
        self.user = .empty
        self.profileRepository = profileRepository
        self.authenticationViewModel = authenticationViewModel
        
        // Try to fetch profile picture from database
        fetchUser()
        fetchProfilePicture()
    }
    
    func fetchUser() {
        self.user = authenticationViewModel.user ?? .empty
    }
    
    func updateUser(user: User) {
        self.user = user // Store changes locally
        profileRepository.updateUser(user: user) { result in
            switch result {
                case .success(let message):
                    self.successMessage = message
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchProfilePicture() {
        profileRepository.fetchProfilePicture(for: self.user) { [weak self] image in
            self?.profilePicture = image
        }
    }
    
    func deleteProfilePicture() {
        profilePicture = UIImage(resource: .defaultProfilePicture)
        let path = "images/profilePictures/\(user.id).jpg"
        profileRepository.deleteProfilePicture(path: path) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
        
        user.pictureURL = ""
        updateUser(user: user)
    }
    
    func updateProfilePicture(from item: PhotosPickerItem?) {
        
        Task { @MainActor in
            
            // Convert item to actual image
            if let data = try? await item?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    profilePicture = uiImage
                }
            }
            
            // Update in database
            let imageID = "\(user.id).jpg"
            let newURL = profileRepository.updateProfilePicture(image: profilePicture, imageID: imageID) { result in
                switch result {
                    case .success(let message):
                        self.successMessage = message
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
            }
            
            user.pictureURL = newURL
            updateUser(user: user)
        }
    }
    
    func updateEmail(to newEmail: String) {
        authenticationViewModel.updateEmail(to: newEmail) { result in
            switch result {
            case .success(let message):
                self.user.email = newEmail // Save locally
                self.successMessage = message
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updatePassword(to newPassword: String, authenticationViewModel: AuthenticationViewModel) {
        authenticationViewModel.updatePassword(to: newPassword) { result in
            switch result {
            case .success(let message):
                self.successMessage = message
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signOut() {
        authenticationViewModel.signOut()
    }
}

extension ProfileViewModel {
    static let preview: ProfileViewModel = {
        let vm = ProfileViewModel(
            profileRepository: ProfileRepository(),
            authenticationViewModel: AuthenticationViewModel()
        )
        vm.user = User(
            id: "preview123",
            email: "pablo@example.com",
            firstName: "Pablo",
            lastName: "García",
            bio: "SwiftUI enjoyer",
            pictureURL: ""
        )
        vm.profilePicture = UIImage(resource: .defaultProfilePicture)
        return vm
    }()
}

