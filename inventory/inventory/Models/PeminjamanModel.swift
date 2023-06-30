//
//  PeminjamanModel.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import Foundation
import CoreData

struct PeminjamanModel: Identifiable, Decodable  {
    let id: Int
    let product_id: Int
    let employee_id: Int
    let qty: Int
    let start_date: String
    let end_date: String
    let status: String
    let is_active: Int
}

extension PeminjamanModel {
    var formattedStartDate: Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter.date(from: start_date) ?? Date()
        }
    var formattedEndDate: Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return formatter.date(from: end_date) ?? Date()
        }
    var statusFormatted: String {
        return status
    }
}
