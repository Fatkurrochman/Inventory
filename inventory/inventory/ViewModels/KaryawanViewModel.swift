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
        }
        InventoryCoreDataManager.shared.save()
        fetchKaryawan()
    }
}
