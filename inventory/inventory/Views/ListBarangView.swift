//
//  ListBarangView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct ListBarangContenntView: View {
    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ListBarangView: View {
    var body: some View {
        ScrollView {
            VStack {
                ListBarangContenntView()
            }
        }
    }
}

struct ListBarangView_Previews: PreviewProvider {
    static var previews: some View {
        ListBarangView()
    }
}
