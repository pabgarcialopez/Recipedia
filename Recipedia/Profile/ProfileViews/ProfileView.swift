//
//  ProfileView.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    private var profilePicture: some View {
        return profileViewModel.profilePicture
            .resizable()
            .scaledToFit()
            .padding()
            .overlay(Circle().stroke(Color.black))
            .clipShape(Circle())
            .frame(width: 80, height: 80)
    }
    
    private var user: User { return profileViewModel.user }
        
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        profilePicture
                        Text(user.fullName)
                    }
                    
                    Spacer()
                    NavigationLink {
//                        ProfileEditView()
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
                .padding()
                .background(.red)
                
                Button("Log out") {
                    profileViewModel.signOut()
                }
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Profile")
        }
        
    }
}

#Preview {
    ProfileView(profileViewModel: ProfileViewModel(
        authenticationViewModel: AuthenticationViewModel()))
}
