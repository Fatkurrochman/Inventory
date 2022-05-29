//
//  InventoryHelper.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import Foundation
import SwiftUI

struct InventoryHelper {
    static var companyLogo = Image("CompanyLogo")
    static var buttonDashboard = Color("ButtonDashboard")
    static var groupColor = Color("GroupColor")
}

import SwiftUI

extension UserDefaults{
    func setAuthenticate(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isAuthenticate.rawValue)
    }
    
    func getAuthenticate() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.isAuthenticate.rawValue) as? Bool ?? false
    }
}

enum UserDefaultsKeys : String {
    case isAuthenticate
}
