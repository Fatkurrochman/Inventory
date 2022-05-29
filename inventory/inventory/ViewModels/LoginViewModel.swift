//
//  LoginViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import Firebase
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String
    @Published var password: String
    @Published var isAuthenticate: Bool
    
    init() {
        self.username = ""
        self.password = ""
        self.isAuthenticate = UserDefaults.standard.getAuthenticate()
    }
    
    func authenticate() {
        Auth.auth().signIn(withEmail: self.username, password: self.password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                self.isAuthenticate = true
                UserDefaults.standard.setAuthenticate(value: true)
            }
        }
    }
    
    func logout() {
        self.isAuthenticate = false
        UserDefaults.standard.setAuthenticate(value: false)
    }
}
