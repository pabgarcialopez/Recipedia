//
//  AccountView.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

enum AccountSheetView: String, Identifiable {
    case changeEmail, changePassword
    var id: String { return rawValue }
}

struct AccountView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    @State private var accountSheetView: AccountSheetView? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            LinksMenu(items: [
                AnyView(Button(action: showChangeEmailView) {
                    Text("Change email")
                        .padding()
                        .frame(maxWidth: .infinity)
                }),
                
                AnyView(Button(action: showChangePasswordView) {
                    Text("Change password")
                        .padding()
                        .frame(maxWidth: .infinity)
                })
            ])
            
            Button(action: deleteAccount) {
                Text("Delete account")
                    .foregroundStyle(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(.red))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxHeight: .infinity, alignment: .top)
        .sheet(item: $accountSheetView) { accountSheetView in
            switch accountSheetView {
                case .changeEmail: ChangeEmailView(profileViewModel: profileViewModel)
                case .changePassword: ChangePasswordView(profileViewModel: profileViewModel)
            }
        }
    }
    
    func showChangeEmailView() { accountSheetView = .changeEmail }
    
    func showChangePasswordView() { accountSheetView = .changePassword }
    
    func deleteAccount() {
        
    }
}

#Preview {
    AccountView(profileViewModel: .preview)
}
