//
//  BarangViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class BarangViewModel: ObservableObject {
    @Published var id: Int = Int()
    @Published var code: String = ""
    @Published var name: String = ""
    @Published var barangQty: Int64 = 0
    @Published var qty: String = ""
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var barang: [ProductModel] = []
    @Published var productIdSelected: String = ""
    @Published var isEmptyForm: Bool = false
    @Published var isErrorForm: Bool = false
    @Published var showingAlertDelete = false
    
    let URLHelpers = URLHelper()
    
    init() {
        setDefaultForm()
        fetchBarang()
    }
    
    func openAlert(model:ProductModel){
        showingAlertDelete = true
        self.productIdSelected = String(model.id)
        
    }

    func setDefaultForm() {
        self.name = ""
        self.code = ""
        self.barangQty = 0
        self.qty = ""
    }
    
    func fillForm(model: ProductModel) {
        self.id = model.id
        self.name = model.name
        self.status = "edit"
        self.code = model.code
        self.qty = String(model.qty)
        self.barangQty = Int64(model.qty)
        self.isPresented = true
    }
    
    func fetchBarang() {
        let request = URLHelpers.urlRequest(urlPath: "/product", method: "GET", useAuthorization: true)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedProduct = try JSONDecoder().decode([ProductModel].self, from: data)
                     
                        self.barang = decodedProduct
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func create() {
        if (self.name.isEmpty || self.code.isEmpty || self.qty.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            let body : [String:String] = [
                "name": self.name,
                "code": self.code,
                "qty": "\(self.qty)",
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/product", method: "POST", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 201 {
                    DispatchQueue.main.async {
                        self.isErrorForm = false
                        self.fetchBarang()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isErrorForm = true
                    }
                }
            }.resume()
        }
    }
    
    func edit() {
        if (self.name.isEmpty || self.code.isEmpty || self.qty.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            let body : [String:String] = [
                "name": self.name,
                "code": self.code,
                "qty": "\(self.qty)",
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/product/\(self.id)", method: "PUT", useAuthorization: true)
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
                        self.fetchBarang()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isErrorForm = true
                    }
                }
            }.resume()
        }
    }
    
    func deleteById() {
        let request = URLHelpers.urlRequest(urlPath: "/product/\(self.productIdSelected)", method: "DELETE", useAuthorization: true)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.fetchBarang()
                }
            } else {
                print("You can't delete this record")
            }
        }.resume()
    }
}
