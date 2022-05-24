//
//  BarangModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

struct BarangModel {
    let barang: Barang
    
    var id: NSManagedObjectID {
        return barang.objectID
    }
    var barangUUID: UUID {
        return barang.barang_uuid ?? UUID()
    }
    var name: String {
        return barang.name ?? ""
    }
    var code: String {
        return barang.code ?? ""
    }
    var qty: Int64 {
        return barang.qty
    }
}
