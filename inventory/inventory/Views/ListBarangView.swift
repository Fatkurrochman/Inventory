//
//  ListBarangView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct ListBarangContenntView: View {
    var barang: BarangModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(barang.name)
                    .font(.system(size: 15, design: .rounded))
                Text(barang.code)
                .font(.system(size: 13, design: .rounded))
//                    Text("Departemen")
//                        .font(.system(size: 13, design: .rounded))
//                        .foregroundColor(Color.init(.systemGray))
            }
            Spacer()
            Text(String(barang.qty))
                .font(.system(size: 15, design: .rounded))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.groupColor))
    }
}

struct ListBarangView: View {
    @ObservedObject var barangVM: BarangViewModel
    var body: some View {
        ScrollView {
            ForEach (barangVM.filterBarang(), id:\.id) {
                key in
                VStack(spacing: 10) {
                    ListBarangContenntView(
                        barang: key)
                }
                .padding(.horizontal)
            }
        }
    }
}

//struct ListBarangView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListBarangView()
//    }
//}
