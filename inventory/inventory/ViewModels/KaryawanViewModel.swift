//
//  KaryawanViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class KaryawanViewModel: ObservableObject {
    @Published var id: NSManagedObjectID = NSManagedObjectID()
    @Published var karyawanUUID = UUID()
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var badge_id: String = ""
    @Published var department: String = ""
    
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var karyawan: [KaryawanModel] = []
    
    init() {
        setDefaultForm()
        fetchKaryawan()
    }
    
    func filterKaryawan() -> [KaryawanModel] {
        return karyawan.filter { karyawan in
            if karyawan.badge_id != "" {
                return true
            }
            else {
                return false
            }
        }
    }
    func setDefaultForm() {
        self.name = ""
        self.email = ""
        self.badge_id = ""
        self.department = ""
        self.email = ""
        self.karyawanUUID = UUID()
    }
    func fillForm(model: KaryawanModel) {
        self.id = model.id
        self.name = model.name
        self.status = "edit"
        self.badge_id = model.badge_id
        self.department = model.department
        self.karyawanUUID = model.karyawanUUID
        self.email = model.email
        self.isPresented = true
    }
    func fetchKaryawan() {
        self.karyawan = InventoryCoreDataManager.shared.fetchKaryawan()
    }
    func create() {
        let karyawan = Karyawan(context: InventoryCoreDataManager.shared.viewContext)
        karyawan.name = self.name
        karyawan.email = self.email
        karyawan.department = self.department
        karyawan.badge_id = self.badge_id
        karyawan.karyawan_uuid = self.karyawanUUID
        InventoryCoreDataManager.shared.save()
        fetchKaryawan()
    }
    func edit() {
        let karyawan = InventoryCoreDataManager.shared.getKaryawanById(id: self.id)
        if let karyawan = karyawan {
            karyawan.name = self.name
            karyawan.email = self.email
            karyawan.badge_id = self.badge_id
            karyawan.department = self.department
        }
        InventoryCoreDataManager.shared.save()
        fetchKaryawan()
    }
    func deleteById(model: KaryawanModel) {
        let karyawan = InventoryCoreDataManager.shared.getKaryawanById(id: model.id)
        if let karyawan = karyawan {
            InventoryCoreDataManager.shared.viewContext.delete(karyawan)
            InventoryCoreDataManager.shared.save()
        }
        fetchKaryawan()
    }
}
