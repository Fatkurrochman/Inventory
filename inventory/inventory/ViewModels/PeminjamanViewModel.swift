//
//  PeminjamanViewModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class PeminjamanViewModel: ObservableObject {
    @Published var id: NSManagedObjectID = NSManagedObjectID()
    @Published var peminjamanUUID: UUID = UUID()
    @Published var peminjamanStatus: String = ""
    @Published var peminjamanQty: Int64 = 0
    @Published var qty: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    
    @Published var karyawanId: Karyawan = Karyawan()
    @Published var karyawanName: String = ""
    @Published var karyawanEmail: String = ""
    @Published var karyawanDepartement: String = ""
    
    @Published var barangName: String = ""
    @Published var barangId: Barang = Barang()
    
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    
    @Published var karyawan: [KaryawanModel] = []
    @Published var barang: [BarangModel] = []
    @Published var peminjaman: [PeminjamanModel] = []
    
    @Published var karyawanBadge = ""
    
    init() {
        setDefaultForm()
        fetchBarang()
        fetchPeminjaman()
    }
    func fetchBarang() {
        self.barang = InventoryCoreDataManager.shared.fetchBarang()
    }
    func fillForm(model: PeminjamanModel) {
        self.id = model.id
        self.status = "edit"
        self.peminjamanUUID = model.peminjamanUUID
        self.karyawanId = model.karyawanId
        self.qty = String(model.peminjamanQty)
        self.karyawanBadge = model.karyawanId.badge_id ?? ""
        
        if model.peminjaman.barang_id == model.barangId {
            self.barangName = model.barangId.name ?? ""
            self.barangId = model.barangId
        } else {
            self.barangName = ""
            self.barangId = Barang()
        }
        self.isPresented = true
        checkKaryawan()
    }
    func checkKaryawan() {
        let dataKaryawan = InventoryCoreDataManager.shared.getKaryawanByBadge(badge: self.karyawanBadge)
        if (dataKaryawan != nil) {
            karyawanId = dataKaryawan!
            karyawanName = karyawanId.name ?? ""
            karyawanDepartement = karyawanId.department ?? ""
            karyawanEmail = karyawanId.email ?? ""
        }
    }
    func filterPeminjaman() -> [PeminjamanModel] {
        return peminjaman.filter { peminjaman in
            return true
        }
    }
    func fetchPeminjaman() {
        self.peminjaman = InventoryCoreDataManager.shared.fetchPeminjaman()
    }
    func setDefaultForm() {
        self.startDate = Date()
        self.endDate = Date()
        self.peminjamanQty = 0
        self.qty = ""
        self.karyawanBadge = ""
        self.karyawanName = ""
        self.karyawanDepartement = ""
        self.karyawanEmail = ""
        self.barangName = ""
        self.peminjamanUUID = UUID()
        self.barangId = Barang()
        self.karyawanId = Karyawan()
    }
    func create() {
        let peminjaman = Peminjaman(context: InventoryCoreDataManager.shared.viewContext)
        peminjaman.peminjaman_uuid = self.peminjamanUUID
        peminjaman.status = "Dipinjam"
        peminjaman.start_date = self.startDate
        peminjaman.end_date = self.endDate
        peminjaman.qty = Int64(self.qty) ?? 0
        peminjaman.karyawan_id = self.karyawanId
        peminjaman.barang_id = self.barangId
        
        InventoryCoreDataManager.shared.save()
        fetchPeminjaman()
    }
    func deleteById(model: PeminjamanModel) {
        let peminjaman = InventoryCoreDataManager.shared.getPeminjamanById(id: model.id)
        if let peminjaman = peminjaman {
            InventoryCoreDataManager.shared.viewContext.delete(peminjaman)
            InventoryCoreDataManager.shared.save()
        }
        fetchPeminjaman()
    }
}
