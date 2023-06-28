//
//  KaryawanViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class KaryawanViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var badge_id: String = ""
    @Published var department: String = ""
    @Published var depatment_name: String = ""
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var isEmptyForm: Bool = false
    @Published var isErrorForm: Bool = false
    @Published var karyawan: [KaryawanModel] = []
    @Published var departementList: [DepartemenModel] = []
    @Published var showingAlertDelete = false
    @Published var productIdSelected: String = ""
    
    let URLHelpers = URLHelper()
    
    init() {
        setDefaultForm()
        fetchDepartemen()
        fetchKaryawan()
    }
    
    func openAlert(model:KaryawanModel){
        showingAlertDelete = true
        self.productIdSelected = String(model.id)
    }
    
    func setDefaultForm() {
        self.name = ""
        self.email = ""
        self.badge_id = ""
        self.department = ""
        self.email = ""
        self.depatment_name = "Pilih Departemen"
    }
    
    func fillForm(model: KaryawanModel) {
        self.id = model.id
        self.name = model.name
        self.status = "edit"
        self.badge_id = model.badge_id
        self.department = String(model.department_id)
        self.depatment_name = generateDepartmentName(department_id: model.department_id)
        self.email = model.email
        self.isPresented = true
    }
    
    func generateDepartmentName(department_id: Int) -> String {
        let dep_ids = self.departementList.filter({ d in
            d.id == department_id
        })
        if dep_ids.count > 0 {
            return dep_ids[0].name
        } else {
            return ""
        }
    }
    
    func fetchKaryawan() {
        let request = URLHelpers.urlRequest(urlPath: "/employee", method: "GET", useAuthorization: true)
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
                        let decodedData = try JSONDecoder().decode([KaryawanModel].self, from: data)
                        self.karyawan = decodedData
                    } catch let error {
                        print("Error fetch Karyawan: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchDepartemen() {
        let request = URLHelpers.urlRequest(urlPath: "/department", method: "GET", useAuthorization: true)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else {     return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([DepartemenModel].self, from: data)
                        self.departementList = decodedUsers
                    } catch let error {
                        print("Error fetch Department: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func create() {
        if (self.name.isEmpty || self.email.isEmpty || self.department.isEmpty || self.badge_id.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            let body : [String:String] = [
                "name": self.name,
                "email":self.email,
                "department_id":"\(self.department)",
                "badge_id":self.badge_id,
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else {return}
            var request = URLHelpers.urlRequest(urlPath: "/employee", method: "POST", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    self.fetchKaryawan()
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
    
    func edit() {
        if (self.name.isEmpty || self.email.isEmpty || self.department.isEmpty || self.badge_id.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            let body : [String:String] = [
                "name": self.name,
                "email":self.email,
                "department_id":"\(self.department)",
                "badge_id":self.badge_id,
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else {return}
            var request = URLHelpers.urlRequest(urlPath: "/employee/\(self.id)", method: "PUT", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    self.fetchKaryawan()
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
    
    func deleteById() {
        let request = URLHelpers.urlRequest(urlPath: "/employee/\(self.productIdSelected)", method: "DELETE", useAuthorization: true)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.fetchKaryawan()
                }
            } else {
                print("You can't delete this record")
            }
        }.resume()
    }
}
