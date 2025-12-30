//
//  ChangeEmailView.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    @State private var newEmail = ""
    @State private var indication = ""
    
    @State private var alertShowing = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    private var user: User { profileViewModel.user }
    
    private var saveButton: some View {
        Button(action: {
            updateEmail()
            showAlert(
                title: "Next steps",
                message: "Please go to your \(newEmail) mailbox and verify your new email. You will now be logged out.")
        }) {
            Text("Save")
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .foregroundStyle(.blue)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(.blue))
        .buttonStyle(.plain)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Change your email")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            VStack(spacing: 12) {
                LabeledTextField(
                    label: "Current email",
                    prompt: "Enter your current email",
                    text: .constant(user.email),
                    disabled: true
                )
                
                LabeledTextField(
                    label: "New email",
                    prompt: "Enter your new email",
                    text: $newEmail,
                    lowercase: true
                )
            }
            
            if !indication.isEmpty {
                Text(indication)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.top, 20)
            }
            
            saveButton
                .padding(.top, 20)
            
            Text("When saving your changes, you will be logged out from this app and asked to verify your new email.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            if profileViewModel.isLoading {
                ProgressView()
                    .padding(.top, 20)
            }
            
            Spacer()
            
        }
        .padding(30)
        .alert(alertTitle, isPresented: $alertShowing, actions: {
            Button("OK") {
                profileViewModel.signOut()
            }
        }, message: { Text(alertMessage) })
        .onChange(of: newEmail, updateIndication)
        .onChange(of: profileViewModel.authMessage) { _, newValue in
            guard let message = newValue else { return }
            showAlert(title: "Success", message: message)
            profileViewModel.authMessage = nil // Reset so future changes fire again
            
        }
    }
    
    func isValidEmail() -> Bool {
        let regex = try! Regex(#"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#)
        return newEmail.firstMatch(of: regex) != nil
    }
    
    func updateIndication() {
        
        if newEmail.lowercased() == user.email.lowercased() {
            indication = "Your new email cannot be the same as your current one"
        }
        
        else if !isValidEmail() && !newEmail.isEmpty {
            indication = "Please, enter a valid email"
        }
        
        else { indication = "" }
    }
    
    func disableSaveButton() -> Bool {
        return newEmail.isEmpty ||
        newEmail.lowercased() == user.email.lowercased() ||
        !isValidEmail()
    }
    
    func showAlert(title: String, message: String = "") {
        alertShowing = true
        alertTitle = title
        alertMessage = message
    }
    
    func updateEmail() {
        profileViewModel.updateEmail(to: newEmail)
    }
}

#Preview {
    ChangeEmailView(profileViewModel: .preview)
}
