//
//  LoginView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/08/2023.
//

import SwiftUI
import Auth0

class GlobalState: ObservableObject {
    static let shared = GlobalState()
    
    @Published var isAuthenticated: Bool = true
}

struct LoginView: View {
    @ObservedObject var gs = GlobalState.shared
    
    var body: some View {
        if gs.isAuthenticated == false{
            Button("Log in") {
                login()
            }
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        else {
            Button("Log out") {
                logout()
            }
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

extension LoginView {
    private func login() {
        Auth0
        .webAuth()
        .start { result in
            switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                case .success(let credentials):
                    gs.isAuthenticated = true
                    print("Credentials: \(credentials)")
                    print("ID token: \(credentials.idToken)")
            }
        }
    }
    
    private func logout() {
        Auth0
        .webAuth()
        .clearSession { result in
            switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                case .success:
                    gs.isAuthenticated = false
          }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
