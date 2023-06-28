//
//  ProductModel.swift
//  inventory
//
//  Created by Muhammad Rasyid khaikal on 02/12/22.
//

import Foundation
struct ProductModel: Identifiable, Decodable {
    let id : Int
    let name : String
    let code : String
    let qty : Int
    let is_active : Int
}
