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
struct RecipediaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()

    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.user != nil {
                RootView(authenticationViewModel: authenticationViewModel)
            } else {
                AuthenticationView()
                    .environmentObject(authenticationViewModel)
            }
        }
    }
}

