//
//  BarangViewModel.swift
//  inventory
//
//  Created by Rasyid Khaikal on 24/05/22.
//

import Foundation
import CoreData

class UserViewModel: ObservableObject {
    @Published var id: Int = Int()
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var barang: [ProductModel] = []
    @Published var isEmptyForm: Bool = false
    @Published var isErrorForm: Bool = false
    @Published var isPasswordMatch: Bool = false
    
    let URLHelpers = URLHelper()

    func create() {
        if (self.username.isEmpty || self.password.isEmpty || self.confirmPassword.isEmpty) {
            self.isEmptyForm = true
            self.isErrorForm = false
        } else if(self.password != self.confirmPassword) {
            self.isPasswordMatch = true
            self.isEmptyForm = false
            self.isErrorForm = false
        } else {
            self.isEmptyForm = false
            self.isPasswordMatch = false
            let body : [String:String] = [
                "username": self.username,
                "password":self.password,
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/register", method: "POST", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isErrorForm = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isErrorForm = true
                    }
                }
            }.resume()
        }
    }
}
