//
//  InventoryCoreDataHelper.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

class InventoryCoreDataManager {
    let persisntentContainer: NSPersistentContainer
    static let shared = InventoryCoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persisntentContainer.viewContext
    }
    private init() {
        persisntentContainer = NSPersistentContainer(name: "inventory")
        persisntentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unable to initialize coredata stack \(error)")
            }
        }
    }
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
