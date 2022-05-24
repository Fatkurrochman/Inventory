//
//  LoginView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
//        NavigationView {
            VStack {
                InventoryHelper.companyLogo
                HStack {
                    VStack {
                        Text("LOGIN")
                        Text("PASSWORD")
                        Button("LOGIN") {
                            print("AAA")
                        }
                    }
                }
            }
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
