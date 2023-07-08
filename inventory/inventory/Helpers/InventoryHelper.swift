//
//  InventoryHelper.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import Foundation
import SwiftUI

//extension UIApplication {
//    func endEditing() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}

struct InventoryHelper {
    static var companyLogo = Image("CompanyLogo")
    static var buttonDashboard = Color("ButtonDashboard")
    static var groupColor = Color("GroupColor")
}

extension UserDefaults{
//    func setAuthenticate(value: Bool) {
//        set(value, forKey: UserDefaultsKeys.isAuthenticate.rawValue)
//    }
    
    func getAuthenticate() -> Bool {
        let token =  UserDefaults.standard.object(forKey: UserDefaultsKeys.token.rawValue) as? String ?? ""
        if (token == "") {
            return false
        } else {
            return true
        }
    }
    
    func setAuthenticate(token: String, uid: Int, username: String) {
        set(token, forKey: UserDefaultsKeys.token.rawValue)
        set(uid, forKey: UserDefaultsKeys.uid.rawValue)
        set(username, forKey: UserDefaultsKeys.username.rawValue)
    }
}

enum UserDefaultsKeys : String {
    case isAuthenticate
    case token
    case uid
    case username
}
