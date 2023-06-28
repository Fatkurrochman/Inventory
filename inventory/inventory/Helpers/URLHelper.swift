//
//  URLHelper.swift
//  inventory
//
//  Created by Rinaldi on 27/06/23.
//

import Foundation

struct URLHelper {
    let url = "http://185.201.9.237"
    let port = "8000"
    
    func urlRequest(urlPath: String, method: String, useAuthorization: Bool) -> URLRequest {
        guard let url = URL(string: "\(self.url):\(self.port)\(urlPath)") else {
            fatalError("Missing URL")
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        if useAuthorization {
            request.setValue("Bearer \(UserDefaults.standard.object(forKey: UserDefaultsKeys.token.rawValue) as? String ?? "")", forHTTPHeaderField:"Authorization")
        }
        return request
    }
}
