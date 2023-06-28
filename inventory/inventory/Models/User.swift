//
//  User.swift
//  inventory
//
//  Created by Muhammad Rasyid khaikal on 29/11/22.
//

import Foundation
struct User: Identifiable, Decodable {
    let id : Int
    let username : String
    let token : String
}
struct UserLogout:  Decodable {
    let message : String
    let status : Bool
}
struct UserAuthentication: Decodable {
    let message: String
    let token: String
//    let uid: Int
//    let username: String
}

