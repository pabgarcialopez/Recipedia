//
//  HomeView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var selectedTab: Int = 0
}


struct RootView: View {
        
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject private var recipeViewModel: RecipeViewModel
    @StateObject private var globalImageLoader: ImageLoader
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @StateObject private var router = AppRouter()
    
    init(authenticationViewModel: AuthenticationViewModel) {
        self.authenticationViewModel = authenticationViewModel
        
        self._recipeViewModel = StateObject(wrappedValue: RecipeViewModel())
        self._globalImageLoader = StateObject(wrappedValue: ImageLoader())
        // Inject authenticationViewModel into profileViewModel
        self._profileViewModel = StateObject(wrappedValue: ProfileViewModel(authenticationViewModel: authenticationViewModel))
    }
    
    var body: some View {
                
        TabView(selection: $router.selectedTab) {
            RecipeListView(recipeViewModel: recipeViewModel)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
            
            RecipeCreationView(recipeViewModel: recipeViewModel)
                .tabItem { Label("Create", systemImage: "plus") }
                .tag(1)
            
            // TODO: use RemoteImageView for ProfileView
            ProfileView(profileViewModel: profileViewModel)
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(2)
        }
        .environmentObject(router)
        .environment(\.imageLoader, globalImageLoader)
        
    }
}

#Preview {
    RootView(authenticationViewModel: AuthenticationViewModel())
}
