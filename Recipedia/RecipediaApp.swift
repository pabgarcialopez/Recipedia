//
//  RecipediaApp.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let user = authenticationViewModel.user {
                Text("User logged in: \(user.email)")
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
