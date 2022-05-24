//
//  KaryawanModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

struct KaryawanModel {
    let karyawan: Karyawan
    
    var id: NSManagedObjectID {
        return karyawan.objectID
    }
    var karyawanUUID: UUID {
        return karyawan.karyawan_uuid ?? UUID()
    }
    var badge_id: String {
        return karyawan.badge_id ?? ""
    }
    var name: String {
        return karyawan.name ?? ""
    }
    var department: String {
        return karyawan.department ?? ""
    }
    var email: String {
        return karyawan.email ?? ""
    }
}
