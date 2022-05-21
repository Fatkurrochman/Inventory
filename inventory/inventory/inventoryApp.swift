//
//  inventoryApp.swift
//  inventory
//
//  Created by Rinaldi on 21/05/22.
//

import SwiftUI

@main
struct inventoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
