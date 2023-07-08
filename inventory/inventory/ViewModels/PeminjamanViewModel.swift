//
//  PeminjamanViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class PeminjamanViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var peminjamanUUID: UUID = UUID()
    @Published var peminjamanStatus: String = ""
    @Published var peminjamanQty: Int64 = 0
    @Published var qty: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var karyawanId: String = ""
    @Published var karyawanName: String = ""
    @Published var karyawanEmail: String = ""
    @Published var karyawanDepartement: String = ""
    @Published var barangName: String = ""
    @Published var barangId: String = ""
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var isEmptyForm: Bool = false
    @Published var isErrorForm: Bool = false
    @Published var karyawan: [KaryawanModel] = []
    @Published var peminjaman: [PeminjamanModel] = []
    @Published var departementList: [DepartemenModel] = []
    @Published var employeeList: [KaryawanModel] = []
    @Published var productList: [ProductModel] = []
    @Published var karyawanDetail: [KaryawanDetailModel] = []
    @Published var showingAlertDelete = false
    @Published var productIdSelected: String = ""
    @Published var karyawanBadge = ""
    @Published var cancelOrderId = 0
    @Published var showingAlertFailed = false
    @Published var avoidStatus = ["Cancel", "Returned"]
    
    let URLHelpers = URLHelper()
     
    init() {
        setDefaultForm()
        fetchEmployee()
        fetchProductList()
        fetchOrderList()
        fetchDepartmentList()
    }
    
    func fetchDepartmentList() {
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
    
    func openAlert(model:PeminjamanModel){
        showingAlertDelete = true
        self.productIdSelected = String(model.id)
        cancelOrderId = model.id
    }

    func fetchOrderList() {
        let request = URLHelpers.urlRequest(urlPath: "/order", method: "GET", useAuthorization: true)
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
                        let decodedProduct = try JSONDecoder().decode([PeminjamanModel].self, from: data)
                        self.peminjaman = decodedProduct
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func generateEmployeeName(employee_id: Int) -> String {
        let emp_ids = self.employeeList.filter({ e in
            e.id == employee_id
        })
        if emp_ids.count > 0 {
            return emp_ids[0].name
        } else {
            return ""
        }
    }
    
    func getProductQty(product_id: Int) -> Int {
        let prod_ids = self.productList.filter({ p in
            p.id == product_id
        })
        if prod_ids.count > 0 {
            return prod_ids[0].qty
        } else {
            return 0
        }
    }
    
    func generateProductName(product_id: Int) -> String {
        let prod_ids = self.productList.filter({ p in
            p.id == product_id
        })
        if prod_ids.count > 0 {
            return prod_ids[0].name
        } else {
            return ""
        }
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
    
    func fillForm(model: PeminjamanModel) {
        self.id = model.id
        self.status = "edit"
        self.qty = String(model.qty)
        self.barangId = String(model.product_id)
        self.barangName = self.generateProductName(product_id: model.product_id)
        self.karyawanId = String(model.employee_id)
        self.karyawanName = self.generateEmployeeName(employee_id: model.employee_id)
        self.startDate = model.formattedStartDate
        self.endDate = model.formattedEndDate
        getDetailEmployee(id: "\(model.employee_id)")
        self.isPresented = true
    }
    
    func getDetailEmployee(id: String) {
        let request = URLHelpers.urlRequest(urlPath: "/employee/\(id)", method: "GET", useAuthorization: true)
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
                        let decodedProduct = try JSONDecoder().decode([KaryawanDetailModel].self, from: data)
                        self.karyawanBadge = decodedProduct[0].badge_id
                        self.karyawanEmail = decodedProduct[0].email
                        self.karyawanDepartement = self.generateDepartmentName(department_id: decodedProduct[0].department_id)
                        self.karyawanName = decodedProduct[0].name
                        print("decode",decodedProduct[0].email)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchEmployee() {
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
                        let decodedUsers = try JSONDecoder().decode([KaryawanModel].self, from: data)

                        self.employeeList = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchProductList() {
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
                        let decodedUsers = try JSONDecoder().decode([ProductModel].self, from: data)

                        self.productList = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func edit(){
        if (self.barangId.isEmpty || self.karyawanId.isEmpty || self.startDate.description.isEmpty || self.endDate.description.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            var formattedStartDate: String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                return formatter.string(from: self.startDate)
                }
            var formattedEndDate: String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-d"
                    return formatter.string(from: self.endDate)
                }
            let body : [String:String] = [
                "product_id": self.barangId,
                "employee_id": self.karyawanId,
                "qty": self.qty,
                "start_date ":"\(formattedStartDate)",
                "end_date": "\(formattedEndDate)",
                "status": "On Loan",
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/order/\(self.id)", method: "PUT", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    print("sukses")
                    DispatchQueue.main.async {
                        self.isErrorForm = false
                        self.fetchOrderList()
                    }
                } else {
                    print("gagal")
                    DispatchQueue.main.async {
                        self.isErrorForm = true
                    }
                }
            }.resume()
        }
    }
    
    func setDefaultForm() {
        self.startDate = Date()
        self.endDate = Date()
        self.peminjamanQty = 0
        self.qty = ""
        self.karyawanBadge = ""
        self.karyawanName = "Pilih Karyawan"
        self.karyawanDepartement = ""
        self.karyawanEmail = ""
        self.barangName = "Pilih Barang"
        self.peminjamanUUID = UUID()
        self.barangId = ""
        self.karyawanId = ""
    }
    
    func create() {
        if (self.barangId.isEmpty || self.karyawanId.isEmpty || self.startDate.description.isEmpty || self.endDate.description.isEmpty) {
            self.isEmptyForm = true
        } else {
            self.isEmptyForm = false
            var formattedStartDate: String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                return formatter.string(from: self.startDate)
                }
            var formattedEndDate: String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-d"
                    return formatter.string(from: self.endDate)
                }
            if ((self.getProductQty(product_id: Int(self.barangId) ?? 0)) >= Int(self.qty) ?? 0) {
                let body : [String:String] = [
                    "product_id": self.barangId,
                    "employee_id":self.karyawanId,
                    "qty": self.qty,
                    "start_date":"\(formattedStartDate)",
                    "end_date":"\(formattedEndDate)",
                    "status":"On Loan",
                ]
                guard let finalBody = try? JSONEncoder().encode(body) else {return}
                var request = URLHelpers.urlRequest(urlPath: "/order", method: "POST", useAuthorization: true)
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
                            self.fetchOrderList()
                        }
                    } else {
                        print("gagal")
                        DispatchQueue.main.async {
                            self.isErrorForm = true
                        }
                    }
                }.resume()
            }
            else {
                self.showingAlertFailed = true
            }
        }
    }
    
    func cancel() {
        let order_ids = self.peminjaman.filter({ p in
            p.id == self.cancelOrderId
        })
        if order_ids.count > 0 {
            let order_id = order_ids[0]
            if avoidStatus.contains(order_id.status) {
                self.showingAlertFailed = true
            } else {
                let body : [String:String] = [
                    "product_id": "\(order_id.product_id)",
                    "employee_id": "\(order_id.employee_id)",
                    "qty": "\(order_id.qty)",
                    "status": "Cancel",
                    "type": "cancel"
                ]
                guard let finalBody = try? JSONEncoder().encode(body) else { return }
                var request = URLHelpers.urlRequest(urlPath: "/order/\(self.cancelOrderId)", method: "PUT", useAuthorization: true)
                request.httpBody = finalBody
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Request error: ", error)
                        return
                    }
                    guard let response = response as? HTTPURLResponse else { return }
                    if response.statusCode == 200 {
                        self.fetchOrderList()
                    } else {
                        print("bahaya", response)
                    }
                }.resume()
            }
        }
    }
    
    func deleteById() {
        let request = URLHelpers.urlRequest(urlPath: "/order/\(self.productIdSelected)", method: "DELETE", useAuthorization: true)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                self.fetchOrderList()
            } else {
                print("bahaya")
            }
        }.resume()
    }
    
    func onComplatePeminjaman(model: PeminjamanModel) {
        if avoidStatus.contains(model.status) {
            self.showingAlertFailed = true
        } else {
            let body : [String:String] = [
                "product_id": "\(model.product_id)",
                "employee_id": "\(model.employee_id)",
                "qty": "\(model.qty)",
                "status": "Returned",
                "type": "returned"
            ]
            guard let finalBody = try? JSONEncoder().encode(body) else { return }
            var request = URLHelpers.urlRequest(urlPath: "/order/\(model.id)", method: "PUT", useAuthorization: true)
            request.httpBody = finalBody
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    self.fetchOrderList()
                } else {
                    print("bahaya")
                }
            }.resume()
        }
    }
}
