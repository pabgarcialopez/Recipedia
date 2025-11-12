//
//  ProfileEditView.swift
//  Recipedia
//
//  Created by Pablo García López on 27/8/25.
//

import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var profileViewModel: ProfileViewModel
    
    private var user: User { profileViewModel.user }
    
    // Store the original user to know whether there were any changes
    @State private var modifiedUser: User
    @State private var originalProfilePicture: UIImage
    @State private var selectedPicture: PhotosPickerItem? = nil
    
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    @State private var alertTitle = ""

    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        self._modifiedUser = State(initialValue: profileViewModel.user)
        self._originalProfilePicture = State(initialValue: profileViewModel.profilePicture)
    }
    

    private var profilePictureHasChanges: Bool {
        return originalProfilePicture.pngData() != profileViewModel.profilePicture.pngData()
    }
    
    private var userInfoHasChanges: Bool {
        let original = profileViewModel.user
        
        let userChanged =
            original.firstName != modifiedUser.firstName ||
            original.lastName  != modifiedUser.lastName ||
            original.bio       != modifiedUser.bio

        return userChanged
    }

    
    private var photosPicker: some View {
        PhotosPicker(selection: $selectedPicture, matching: .images) {
            ZStack(alignment: .bottomTrailing) {
                
                Image(uiImage: profileViewModel.profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black))

                Circle()
                    .fill(Color.white)
                    .frame(width: 28, height: 28)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    )
                    .offset(x: 5, y: 5)
            }
        }
        .onChange(of: selectedPicture) { updateProfilePicture() }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                photosPicker
                Button("Delete", action: deleteProfilePicture)
            }
            
            Divider()
                .padding()
            
            // Details
            VStack(spacing: 15) {
                LabeledTextField(label: "First name", prompt: "Enter your first name", text: $modifiedUser.firstName)
                LabeledTextField(label: "Last name", prompt: "Enter your last name", text: $modifiedUser.lastName)
                LabeledTextField(label: "Biography", prompt: "Enter your biography", text: $modifiedUser.bio, axis: .vertical)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(25)
        .navigationTitle("Edit your profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: updateUser)
                    .disabled(!userInfoHasChanges)
            }
        }
        .onChange(of: profileViewModel.errorMessage) { _, newValue in
            if let message = newValue { showAlert(title: "Error", message: message) }
        }
        .onChange(of: profileViewModel.profileMessage) { _, newValue in
            if let message = newValue { showAlert(title: "Success", message: message) }
        }
        .alert(alertTitle, isPresented: $isShowingAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: { Text(alertMessage) })
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }
    
    func deleteProfilePicture() {
        profileViewModel.deleteProfilePicture()
    }
    
    func updateProfilePicture() {
        profileViewModel.updateProfilePicture(from: selectedPicture)
    }
    
    func updateUser() {
        profileViewModel.updateUser(user: modifiedUser)
    }
}

#Preview {
    ProfileEditView(profileViewModel: .preview)
}
