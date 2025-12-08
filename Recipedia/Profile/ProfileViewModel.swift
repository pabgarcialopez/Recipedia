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
    @Published var authMessage: String? = nil
    @Published var profileMessage: String? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let profileRepository: ProfileRepository
    private let authenticationViewModel: AuthenticationViewModel
    private let imageLoader: ImageLoader
    
    init(profileRepository: ProfileRepository = ProfileRepository(), authenticationViewModel: AuthenticationViewModel) {
        
        self.user = .empty
        self.profileRepository = profileRepository
        self.authenticationViewModel = authenticationViewModel
        self.imageLoader = ImageLoader()
        
        // Observe ImageLoader's published image
        // If these lines are not included, then the profilePicture
        // will always be the default placeholder, since this ProfileViewModel
        // class is not observing the async change made on the imageLoader's image.
        imageLoader.$image
            .receive(on: DispatchQueue.main)
            .assign(to: &$profilePicture)
        
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
                    self.profileMessage = message
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchProfilePicture() {
        self.imageLoader.loadImage(from: "\(PROFILE_PICTURES_PATH)/\(user.pictureURL)")
        self.profilePicture = imageLoader.image
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
                    // TODO: don't mix these messages with the updateUser messages.
                    case .success(_): ()
//                        self.profileMessage = "New profile picture has been set"
                    case .failure(_): ()
//                        self.errorMessage = error.localizedDescription
                }
            }
            
            user.pictureURL = newURL
            updateUser(user: user)
        }
    }
    
    func updateEmail(to newEmail: String) {
        isLoading = true
        authenticationViewModel.updateEmail(to: newEmail) { result in
            self.isLoading = false
            switch result {
                case .success(let message):
                    self.authMessage = message
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updatePassword(from currentPassword: String, to newPassword: String) {
        isLoading = true
        authenticationViewModel.updatePassword(from: currentPassword, to: newPassword) { result in
            self.isLoading = false
            switch result {
                case .success(let msg):
                    self.authMessage = msg
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

