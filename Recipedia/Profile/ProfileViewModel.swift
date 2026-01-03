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
        // Code explanation: imageLoader.$image is a Publisher that emits a new value every time imageLoader.image changes.
        // UI updates must happen on the main thread in SwiftUI and receive(on: DispatchQueue.main)
        // ensures that the values emitted by the publisher are handled on the main thread.
        // Finally, .assign connects the publisher to your @Published var profilePicture in the VM
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
        self.imageLoader.loadImage(from: "\(PROFILE_PICTURES_PATH)/\(user.profilePictureId).\(IMAGE_FORMAT)")
        self.profilePicture = imageLoader.image
    }
    
    func deleteProfilePicture() {
        let path = "\(PROFILE_PICTURES_PATH)/\(user.id).\(IMAGE_FORMAT)"
        profileRepository.deleteProfilePicture(path: path) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
        
        profilePicture = UIImage(resource: .defaultProfilePicture)
        user.profilePictureId = ""
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
            let imageID = user.id
            profileRepository.updateProfilePicture(image: profilePicture, imageID: imageID) { result in
                switch result {
                    case .success(_): ()
                    case .failure(_): ()
                }
            }
            
            user.profilePictureId = imageID
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
            profilePictureId: ""
        )
        vm.profilePicture = UIImage(resource: .defaultProfilePicture)
        return vm
    }()
}

