//
//  LoginView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/08/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
//import Auth0

class GlobalState: ObservableObject {
    static let shared = GlobalState()
    
    @Published var isAuthenticated: Bool = false
}

struct LoginView: View {
    @ObservedObject var gs = GlobalState.shared
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        if gs.isAuthenticated == false{
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Log in") {
                    login()
                }
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
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
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                gs.isAuthenticated = true
            }
        }
    }
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            gs.isAuthenticated = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
