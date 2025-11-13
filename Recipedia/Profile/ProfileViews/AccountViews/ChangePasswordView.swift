//
//  ChangePasswordView.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var newPasswordRepeated = ""
    
    @State private var alertShowing = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var indication = ""
    
    private var strokeColorSaveButton: Color {
        disableSaveButton() ? .gray : .blue
    }
    
    var body: some View {
            
        VStack(alignment: .leading) {
            Text("Change your password")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            VStack(spacing: 12) {
                LabeledTextField(label: "Current password", prompt: "Enter your current password", text: $currentPassword, isSecure: true)
                LabeledTextField(label: "New password", prompt: "Enter your new password", text: $newPassword, isSecure: true)
                LabeledTextField(label: "New password repeated", prompt: "Enter your new password again", text: $newPasswordRepeated, isSecure: true)
                
                Button(action: {
                    updatePassword(to: newPassword)
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(strokeColorSaveButton)
                        )
                })
                .padding(.top, 50)
                .disabled(disableSaveButton())
                
                Spacer()
            }
        }
        .padding(30)
            
        .onChange(of: profileViewModel.errorMessage) { _, newValue in
            if let message = newValue {
                showAlert(title: "Error", message: message)
            }
        }
        .alert(alertTitle, isPresented: $alertShowing, actions: {}, message: {
            Text(alertMessage)
        })
    }
    
    func disableSaveButton() -> Bool {
        let someFieldIsEmpty = currentPassword.isEmpty || newPassword.isEmpty || newPasswordRepeated.isEmpty
        let newPasswordMatches = newPassword == newPasswordRepeated
        return someFieldIsEmpty || !newPasswordMatches
    }
    
    func showAlert(title: String, message: String = "") {
        alertShowing = true
        alertTitle = title
        alertMessage = message
    }
    
    func updatePassword(to newPassword: String) {
        profileViewModel.updatePassword(to: newPassword)
    }
}

#Preview {
    ChangePasswordView(profileViewModel: .preview)
}

