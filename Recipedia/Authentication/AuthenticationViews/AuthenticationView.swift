//
//  ContentView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable {
    case signUp, signIn
    var id: String { return rawValue }
}

struct AuthenticationView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var authSheet: AuthenticationSheetView?
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            Text("Recipedia")
                .font(.largeTitle.bold())
            
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: showSignInSheetView) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Sign in")
                    }
                    .tint(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                Button(action: showSignUpSheetView) {
                    HStack {
                        Image(systemName: "person.badge.plus.fill")
                        Text("Sign up")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.blue)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .padding([.leading, .trailing], 40)
            Spacer().frame(height: 50)
        }
        .sheet(item: $authSheet) { sheet in
            switch sheet {
                case .signUp: SignUpView()
                case .signIn: SignInView()
            }
        }
    }
    
    func showSignUpSheetView() { authSheet = .signUp }
    func showSignInSheetView() { authSheet = .signIn }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel())
}
