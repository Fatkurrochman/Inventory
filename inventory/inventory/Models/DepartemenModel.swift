//
//  DepartemenModel.swift
//  inventory
//
//  Created by Muhammad Rasyid khaikal on 09/12/22.
//

import Foundation
struct DepartemenModel: Identifiable, Decodable {
    let id : Int
    let name : String
    let code : String
}
