//
//  BarangCoreDataHelper.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

extension InventoryCoreDataManager {
    func fetchBarang() -> [BarangModel] {
        let request: NSFetchRequest<Barang> = Barang.fetchRequest()
        do {
            return try viewContext.fetch(request).map(BarangModel.init).sorted { $0.code < $1.code }
        } catch {
            return []
        }
    }
    
    func getBarangById(id: NSManagedObjectID) -> Barang? {
        do {
            return try viewContext.existingObject(with: id) as? Barang
        } catch {
            return nil
        }
    }
}
