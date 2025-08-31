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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func updatePassword(to newPassword: String, password: String) {
        profileViewModel.updatePassword(to: newPassword, password: password)
    }
}

#Preview {
    ChangePasswordView(profileViewModel: .preview)
}
