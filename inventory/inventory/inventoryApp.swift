//
//  inventoryApp.swift
//  inventory
//
//  Created by Rinaldi on 21/05/22.
//

import SwiftUI

@main
struct inventoryApp: App {
//    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            TabBarView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
//                    persistenceController.saveData()
                @unknown default:
                    print("unknown")
            }
        }
    }
}
