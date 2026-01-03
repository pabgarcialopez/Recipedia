//
//  Utils.swift
//  RecipeApp
//
//  Created by Pablo García López on 5/8/25.
//

import Foundation
import SwiftUI
import UIKit
import FirebaseAuth

// --------- Allow general use of the authentication functions ------

struct AuthKey: EnvironmentKey {
    static let defaultValue: AuthenticationViewModel = AuthenticationViewModel()
}

extension EnvironmentValues {
    var auth: AuthenticationViewModel {
        get { self[AuthKey.self] }
        set { self[AuthKey.self] = newValue }
    }
}

// --------- Allow general use of the remote image loading ------

private struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self] = newValue }
    }
}



// --------- Hide keyboard functionality ----------------------------

func hideKeyboard() { // Global function to dismiss the keyboard
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

// --------- Stroked border -----------------------------------------
struct Stroked: ViewModifier {
    
    let color: Color
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}

extension View {
    func stroked(color: Color = .black, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 0) -> some View {
        modifier(Stroked(color: color, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}

// --------- Status enum for success or failure in completions -----------------------------------------
enum CompletionStatus {
    case success, failure
}

