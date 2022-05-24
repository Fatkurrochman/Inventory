//
//  PeminjamanModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

struct PeminjamanModel {
    let peminjaman: Peminjaman
    
    var id: NSManagedObjectID {
        return peminjaman.objectID
    }
    var peminjamanUUID: UUID {
        return peminjaman.peminjaman_uuid ?? UUID()
    }
    var peminjamanStatus: String {
        return peminjaman.status ?? ""
    }
    var startDate: Date {
        return peminjaman.start_date ?? Date()
    }
    var endDate: Date {
        return peminjaman.end_date ?? Date()
    }
    var peminjamanQty: Int64 {
        return peminjaman.qty
    }
    
    var karyawanId: Karyawan {
        return peminjaman.karyawan_id ?? Karyawan()
    }
    var barangId: Barang {
        return peminjaman.barang_id ?? Barang()
    }
}
