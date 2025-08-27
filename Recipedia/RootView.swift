//
//  HomeView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

struct RootView: View {
        
    @StateObject var profileViewModel: ProfileViewModel
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var selectedTab = 0
    
    init(authenticationViewModel: AuthenticationViewModel) {
        self.authenticationViewModel = authenticationViewModel
        // Inject authenticationViewModel into profileViewModel
        self._profileViewModel = StateObject(wrappedValue: ProfileViewModel(authenticationViewModel: authenticationViewModel))
    }
    
    var body: some View {
                
        TabView(selection: $selectedTab) {
            RecipeListView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
            
            ProfileView(profileViewModel: profileViewModel)
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(1)
        }
        .environment(\.selectedTab, $selectedTab)
        
    }
}

#Preview {
    RootView(authenticationViewModel: AuthenticationViewModel())
}
