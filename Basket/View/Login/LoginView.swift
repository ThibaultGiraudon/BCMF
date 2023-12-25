//
//  LoginView.swift
//  Basket
//
//  Created by Thibault Giraudon on 27/08/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

class GlobalState: ObservableObject {
    static let shared = GlobalState()
    
    @Published var isAuthenticated: Bool = false
    @Published var presentAddSheet: Bool = false
    @Published var isDarkMode = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkModeEnable")
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkModeEnable")
    }
}

struct LoginView: View {
    @ObservedObject var gs = GlobalState.shared
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        if gs.isAuthenticated == false{
            VStack {
                TextField("Email", text: $email)
                    .foregroundColor(.primary)
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(4.0)
                SecureField("Password", text: $password)
                    .foregroundColor(.primary)
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(4.0)
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
