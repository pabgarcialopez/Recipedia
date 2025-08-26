//
//  HomeView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Text("User logged in: \(authenticationViewModel.user?.email ?? "No user")")
        Button("Sign out", action: authenticationViewModel.signOut)
    }
}

#Preview {
    HomeView(authenticationViewModel: AuthenticationViewModel())
}
