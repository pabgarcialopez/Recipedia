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
    private var signOutButton: some View {
        return Button(action: profileViewModel.signOut) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign out")
            }
            .frame(maxWidth: .infinity)
            .bold()
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
                VStack {
                    profileCard
                    
                    profileNavigationLink("Account", icon: "person.fill", destination: EmptyView())
                    
                    signOutButton
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationTitle("Profile")
        }
    }
    
    func profileNavigationLink<Content: View>(_ title: String, icon: String, destination: Content) -> some View {
        return NavigationLink {
            destination
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(.clear.shadow(.drop(color: .black, radius: 5, x: 5, y: 5)))
                    .stroke(.black, lineWidth: 2)
                
                HStack {
                    Image(systemName: icon)
                    Text(title)
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
                .padding()
            }
            
        }
    }

}

#Preview {
    ProfileView(profileViewModel: ProfileViewModel(
        authenticationViewModel: AuthenticationViewModel()))
}
