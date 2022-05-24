//
//  ListBarangView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct ListColumnBarangView: View {
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
                ListColumnBarangView()
            }
        }
    }
}

struct ListBarangView_Previews: PreviewProvider {
    static var previews: some View {
        ListBarangView()
    }
}
