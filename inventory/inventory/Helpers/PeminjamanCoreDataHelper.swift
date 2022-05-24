//
//  PeminjamanCoreDataHelper.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

extension InventoryCoreDataManager {
    func fetchPeminjaman() -> [PeminjamanModel] {
        let request: NSFetchRequest<Peminjaman> = Peminjaman.fetchRequest()
        do {
            return try viewContext.fetch(request).map(PeminjamanModel.init).sorted { $0.startDate < $1.startDate }
        } catch {
            return []
        }
    }
    func getPeminjamanById(id: NSManagedObjectID) -> Peminjaman? {
        do {
            return try viewContext.existingObject(with: id) as? Peminjaman
        } catch {
            return nil
        }
    }
}
