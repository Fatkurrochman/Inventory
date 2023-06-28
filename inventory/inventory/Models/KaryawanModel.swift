//
//  KaryawanModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

struct KaryawanModel: Identifiable, Decodable {
    let id:Int
    let badge_id :String
    let email :String
    let name: String
    let department_id: Int
    let is_active: Int
}

struct KaryawanDetailModel: Identifiable, Decodable {
    let id:Int
    let badge_id :String
    let email :String
    let name: String
    let department_id: Int
    let is_active: Int
}
