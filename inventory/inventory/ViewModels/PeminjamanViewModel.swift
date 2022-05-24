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
    @Published var barangId: Barang = Barang()
    
    @Published var isPresented: Bool = false
    @Published var status: String = ""
    
    @Published var karyawann: [KaryawanModel] = []
    @Published var barang: [BarangModel] = []
    @Published var peminjaman: [PeminjamanModel] = []
    
    init() {
        setDefaultForm()
//        fetchBarang()
    }
    func setDefaultForm() {
        self.startDate = Date()
        self.endDate = Date()
        self.peminjamanQty = 0
        self.qty = ""
        self.peminjamanUUID = UUID()
    }
}
