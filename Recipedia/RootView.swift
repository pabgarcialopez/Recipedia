//
//  HomeView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

struct RootView: View {
        
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject private var globalImageLoader: ImageLoader
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var selectedTab = 0
    
    init(authenticationViewModel: AuthenticationViewModel) {
        self.authenticationViewModel = authenticationViewModel
        self._globalImageLoader = StateObject(wrappedValue: ImageLoader())
        // Inject authenticationViewModel into profileViewModel
        self._profileViewModel = StateObject(wrappedValue: ProfileViewModel(authenticationViewModel: authenticationViewModel))
    }
    
    var body: some View {
                
        TabView(selection: $selectedTab) {
            RecipeListView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
            
            RecipeCreationView()
                .tabItem { Label("Create", systemImage: "plus") }
                .tag(1)
            
            // TODO: use RemoteImageView for ProfileView
            ProfileView(profileViewModel: profileViewModel)
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(2)
        }
        .environment(\.imageLoader, globalImageLoader)
        
    }
}

#Preview {
    RootView(authenticationViewModel: AuthenticationViewModel())
}
