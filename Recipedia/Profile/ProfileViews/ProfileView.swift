//
//  ProfileView.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    private var user: User { return profileViewModel.user }
    
    private var profilePicture: some View {
        return profileViewModel.profilePicture
            .resizable()
            .scaledToFill()
            .padding()
            .frame(width: 80, height: 80)
    }
    
    private var profileCard: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 22)
                .fill(.blue.opacity(0.15).shadow(.drop(color: .black, radius: 5, x: 5, y: 5)))
                .stroke(.blue, lineWidth: 2)
            
            
            HStack {
                HStack {
                    profilePicture
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text(user.fullName)
                            .font(.title3.bold())
                        Text(user.email ?? "example@example.com")
                    }
                }
                
                Spacer()
                
                NavigationLink {
                     ProfileEditView()
                } label: {
                    Image(systemName: "pencil")
                        .foregroundStyle(.black)
                        .font(.system(size: 25))
                        .padding(.trailing, 10)
                }
                
                
            }
            .padding()
        }
    }
    
    
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    profileCard
                    
                    Button("Log out") {
                        profileViewModel.signOut()
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationTitle("Profile")
        }
        
    }
}

#Preview {
    ProfileView(profileViewModel: ProfileViewModel(
        authenticationViewModel: AuthenticationViewModel()))
}
