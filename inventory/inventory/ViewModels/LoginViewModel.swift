//
//  LoginViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String
    @Published var password: String
    
    init() {
        self.username = ""
        self.password = ""
    }
}
