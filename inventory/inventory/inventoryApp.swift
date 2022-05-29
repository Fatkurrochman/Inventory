//
//  inventoryApp.swift
//  inventory
//
//  Created by Rinaldi on 21/05/22.
//

import SwiftUI
import Firebase

@main
struct inventoryApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var loginVM: LoginViewModel = LoginViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if loginVM.isAuthenticate == false {
                LoginView()
                    .environmentObject(loginVM)
            } else {
                DashboardView()
//                TabBarView()
                    .environmentObject(loginVM)
            }
        }.onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
                @unknown default:
                    print("unknown")
            }
        }
    }
}
