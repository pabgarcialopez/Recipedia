//
//  SignInView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            
            Text("Welcome back!")
                .font(.largeTitle.bold())
            
            Text("Log in to your account to have all your recipes available 🌽")
                .multilineTextAlignment(.center)
                .padding(.vertical, 30)
                
            VStack(spacing: 15) {
                TextField("Enter your email", text: $email)
                    .stroked(cornerRadius: 15)
                SecureField("Enter your password", text: $password)
                    .stroked(cornerRadius: 15)
            }
            
            if let errorMessage = authenticationViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .bold()
            }
            
            Spacer()
            
            Button(action: signIn) {
                Text("Sign in")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
        }
        .padding(50)
    }
    
    func signIn() {
        
    }
}

#Preview {
    SignInView(authenticationViewModel: AuthenticationViewModel())
}
