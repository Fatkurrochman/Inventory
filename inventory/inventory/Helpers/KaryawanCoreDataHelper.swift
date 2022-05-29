//
//  KaryawanCoreDataHelper.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

extension InventoryCoreDataManager {
    func fetchKaryawan() -> [KaryawanModel] {
        let request: NSFetchRequest<Karyawan> = Karyawan.fetchRequest()
        do {
            return try viewContext.fetch(request).map(KaryawanModel.init).sorted { $0.badge_id < $1.badge_id }
        } catch {
            return []
        }
    }
    func getKaryawanByBadge(badge: String) -> Karyawan? {
        let request: NSFetchRequest<Karyawan> = Karyawan.fetchRequest()
        do {
            return try viewContext.fetch(request).filter({ karyawan in
                if karyawan.badge_id == badge {
                    return true
                } else {
                    return false
                }
            }).first
        } catch {
            return nil
        }
    }
    func getKaryawanById(id: NSManagedObjectID) -> Karyawan? {
        do {
            return try viewContext.existingObject(with: id) as? Karyawan
        } catch {
            return nil
        }
    }
}
