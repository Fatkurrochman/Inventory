//
//  ListPeminjamanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct ListPeminjamanView: View {
    @ObservedObject var peminjamanVM: PeminjamanViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ListPeminjamanView_Previews: PreviewProvider {
    static var previews: some View {
        ListPeminjamanView(peminjamanVM: PeminjamanViewModel())
    }
}
