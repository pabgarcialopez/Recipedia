//
//  ProfileView.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import SwiftUI

//struct SettingsSection<Content: View>: View {
//    let title: String
//    @ViewBuilder let content: () -> Content
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Text(title)
//                .font(.headline)
//                .padding(.bottom, 8)
//            
//            VStack(spacing: 0) {
//                content()
//            }
//            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
//            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.separator)))
//        }
//    }
//}

struct SettingsSection: View {
    let title: String
    let items: [AnyView]
    
    init(_ title: String, items: [AnyView]) {
        self.title = title
        self.items = items
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { idx in
                    items[idx]
                    if idx < items.count - 1 { Divider() }
                }
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.separator)))
        }
        .padding(.vertical, 6)
    }
}



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
                        Text(user.email ?? "example@example.com")
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
                    
                    SettingsSection("Your account", items: [
                            AnyView(profileNavigationLink("Account", icon: "person.fill", destination: EmptyView())),
                        ]
                    )
                    
                    SettingsSection("App related", items: [
                            AnyView(profileNavigationLink("Favorites", icon: "heart.fill", destination: EmptyView())),
                        ]
                    )
                    
                    SettingsSection("Support & Info", items: [
                            AnyView(profileNavigationLink("Terms and conditions", icon: "list.bullet", destination: EmptyView())),
                            AnyView(profileNavigationLink("About the app", icon: "info.circle", destination: EmptyView()))
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
    
    func profileNavigationLink<Content: View>(_ title: String, icon: String, destination: Content) -> some View {
        return NavigationLink {
            destination
        } label: {
            HStack {
                Image(systemName: icon)
                    .padding(8)
                    .background(Color(UIColor.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 30)
                Text(title)
                    .padding(.leading, 5)
                Spacer()
                Image(systemName: "chevron.forward")
                    .padding(.trailing, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.black)
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
        }
    }

}

#Preview {
    ProfileView(profileViewModel: ProfileViewModel(
        authenticationViewModel: AuthenticationViewModel()))
}
