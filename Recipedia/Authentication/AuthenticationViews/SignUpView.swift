//
//  SignUpView.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            
            Text("Welcome! 👋")
                .font(.largeTitle.bold())
            
            Text("Register an account to get started 🍄")
                .multilineTextAlignment(.center)
                .padding(.vertical, 30)
                
            VStack(spacing: 15) {
                TextField("Enter your email", text: Binding(
                    get: { email },
                    set: { email = $0.lowercased() }
                ))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .stroked(cornerRadius: 15)
                    
                SecureField("Enter your password", text: $password)
                    .stroked(cornerRadius: 15)
            }
            
            if let errorMessage = authenticationViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .bold()
                    .padding(.top, 20)
            }
            
            Spacer()
            
            Button(action: signUp) {
                Text("Sign up")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
            if authenticationViewModel.isLoading {
                ProgressView()
                    .padding(.top, 20)
            }
        }
        .padding(50)
        .onAppear {
            authenticationViewModel.errorMessage = nil
        }
    }
    
    func signUp() { authenticationViewModel.createNewUser(email: email, password: password) }
}

#Preview {
    SignUpView()
        .environmentObject(AuthenticationViewModel())
}
