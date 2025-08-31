//
//  AccountView.swift
//  Recipedia
//
//  Created by Pablo García López on 31/8/25.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            LinksMenu(items: [
                AnyView(Button(action: changeEmail) {
                    Text("Change email")
                        .padding()
                        .frame(maxWidth: .infinity)
                }),
                
                AnyView(Button(action: changePassword) {
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
    }
    
    func changeEmail() {
        
    }
    
    func changePassword() {
        
    }
    
    func deleteAccount() {
        
    }
}

#Preview {
    AccountView(profileViewModel: .preview)
}
