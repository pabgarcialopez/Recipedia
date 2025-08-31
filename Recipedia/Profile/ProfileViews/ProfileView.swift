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
        return Image(uiImage: profileViewModel.profilePicture)
            .resizable()
            .scaledToFill()
            .padding()
            .frame(width: 80, height: 80)
    }
    
    private var profileCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.blue.opacity(0.15).shadow(.drop(color: .black, radius: 5, x: 5, y: 5)))
                .stroke(.blue, lineWidth: 2)
            
            
            HStack {
                HStack {
                    profilePicture
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text(user.fullName)
                            .font(.title3.bold())
                        Text(user.email)
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    ProfileEditView(profileViewModel: profileViewModel)
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
    
    private var signOutButton: some View {
        return Button(action: profileViewModel.signOut) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign out")
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black)
            .padding()
            .background(.red.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.red, lineWidth: 2)
            )
        }
    }
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    profileCard
                    
                    LinksMenu("Your account", items: [
                        AnyView(ProfileNavigationLink(title: "Account", icon: "person.fill", destination: AccountView(profileViewModel: profileViewModel))),
                        ]
                    )
                    
                    LinksMenu("App related", items: [
                        AnyView(ProfileNavigationLink(title: "Favorites", icon: "heart.fill", destination: EmptyView())),
                        ]
                    )
                    
                    LinksMenu("Support & Info", items: [
                        AnyView(ProfileNavigationLink(title: "Terms and conditions", icon: "list.bullet", destination: EmptyView())),
                        AnyView(ProfileNavigationLink(title: "About the app", icon: "info.circle", destination: EmptyView()))
                        ]
                    )

                    signOutButton
                        .padding(.vertical, 15)
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
