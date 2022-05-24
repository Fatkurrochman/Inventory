//
//  BarangViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class BarangViewModel: ObservableObject {
    @Published var id: NSManagedObjectID = NSManagedObjectID()
    @Published var barangUUID: UUID = UUID()
    @Published var code: String = ""
    @Published var name: String = ""
    @Published var qty: Int64 = 0
    @Published var str_qty: String = ""
    
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    @Published var barang: [BarangModel] = []
    
    init() {
        setDefaultForm()
        fetchBarang()
    }
    
    func filterBarang() -> [BarangModel] {
        return barang.filter { barang in
            if barang.code != "" {
                return true
            }
            else {
                return false
            }
        }
    }
    func setDefaultForm() {
        self.name = ""
        self.code = ""
        self.qty = 0
        self.str_qty = ""
        self.barangUUID = UUID()
    }
    func fetchBarang() {
        self.barang = InventoryCoreDataManager.shared.fetchBarang()
    }
    func create() {
        let barang = Barang(context: InventoryCoreDataManager.shared.viewContext)
        barang.name = self.name
        barang.code = self.code
        barang.qty = Int64(self.str_qty) ?? 0
        barang.barang_uuid = self.barangUUID
        
        InventoryCoreDataManager.shared.save()
        fetchBarang()
    }
    func edit() {
        let barang = InventoryCoreDataManager.shared.getKaryawanById(id: self.id)
        if let barang = barang {
            barang.name = self.name
        }
        InventoryCoreDataManager.shared.save()
        fetchBarang()
    }
}
