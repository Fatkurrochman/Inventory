//
//  LoginViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String
    @Published var password: String
    
    @Published var message: String
    @Published var token: String
    @Published var uid: Int = 0
    @Published var userId: Int = 0
    @Published var isAuthenticate: Bool
    @Published var isEmpty: Bool
    @Published var isErrorLogin: Bool
    
    let URLHelpers = URLHelper()
    
    init() {
        self.username = "admin"
        self.password = "12345"
        self.message = ""
        self.token = ""
        self.uid = 0
        self.isEmpty = false
        self.isErrorLogin = false
        self.isAuthenticate = UserDefaults.standard.getAuthenticate()
    }
    
    func authenticate() {
        if (self.username.isEmpty || self.password.isEmpty) {
            self.isEmpty = true
        } else {
            self.isEmpty = false
            let body : [ String: String ] = [ "username":self.username, "password":self.password ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/login", method: "POST", useAuthorization: false)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,error == nil else {
                    return
                }
                let result = try? JSONDecoder().decode(UserAuthentication.self, from: data)
                if let result = result {
                    DispatchQueue.main.async {
                        if (result.token != "") {
                            self.isAuthenticate = true
                            UserDefaults.standard.setAuthenticate(token: result.token, uid: 0, username: self.username)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isAuthenticate = false
                        self.isErrorLogin = true
                    }
                }
            }.resume()
        }
    }
    
    func logout() {
        self.isAuthenticate = false
        UserDefaults.standard.setAuthenticate(token: "", uid: 0, username: "")
    }
}
