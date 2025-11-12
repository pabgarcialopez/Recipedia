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
    
    var body: some View {
        Form {
            Section {
                Text(user.email)
                TextField("New email", text: Binding(
                    get: { newEmail },
                    set: { newEmail = $0.lowercased() }
                ))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            }
                        
            Section {
                if !indication.isEmpty {
                    Text(indication)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                
                Button("Save", action: {
                    updateEmail()
                    showAlert(
                        title: "Next steps",
                        message: "Please go to your \(newEmail) mailbox and verify your new email. You will now be logged out.")
                })
                    .disabled(disableSaveButton())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("When saving your changes, you will be logged out from this app and asked to verify your new email.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .listRowBackground(Color.clear)
        }
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
        .navigationTitle("Change your email")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func isValidEmail() -> Bool {
        let regex = try! Regex(#"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#)
        return newEmail.firstMatch(of: regex) != nil
    }
    
    func updateIndication() {
        
        if newEmail == user.email {
            indication = "Your new email cannot be the same as your current one"
        }
        
        else if !isValidEmail() && !newEmail.isEmpty {
            indication = "Please, enter a valid email"
        }
        
        else { indication = "" }
    }
    
    func disableSaveButton() -> Bool {
        return newEmail.isEmpty || newEmail == user.email || !isValidEmail()
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
