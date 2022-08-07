//
//  ListBarangView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct ListBarangContentView: View {
    var barang: BarangModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(barang.name)
                    .font(.system(size: 15, design: .rounded))
                Text(barang.code)
                .font(.system(size: 13, design: .rounded))
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
                    ListBarangContentView(
                        barang: key)
                }
                .contextMenu {
                    Button {
                        barangVM.fillForm(model: key)
                    } label: {
                        Label("Ubah Barang", systemImage: "square.and.pencil")
                    }
                    Divider()
                    Button {
                        barangVM.deleteById(model: key)
                    } label: {
                        Text("Hapus")
                        Image(systemName: "trash")
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PeminjamanListBarangContentView: View {
    var barang: BarangModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(barang.name)
                    .font(.system(size: 15, design: .rounded))
                Text(barang.code)
                .font(.system(size: 13, design: .rounded))
            }
            Spacer()
            Text(String(barang.qty))
                .font(.system(size: 15, design: .rounded))
        }
        .padding()
//        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.groupColor))
    }
}

//struct ListBarangView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListBarangView()
//    }
//}
