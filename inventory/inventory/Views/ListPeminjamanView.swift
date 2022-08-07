//
//  ListPeminjamanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct ListPeminjamanContentView: View {
    var peminjaman: PeminjamanModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(peminjaman.barangId == peminjaman.peminjaman.barang_id ? peminjaman.barangId.name ?? "" : "")
                    .font(.system(size: 15, design: .rounded))
                Text(peminjaman.karyawanId == peminjaman.peminjaman.karyawan_id ? peminjaman.karyawanId.name ?? "" : "")
                    .font(.system(size: 13, design: .rounded))
            }
            Spacer()
            Text(String(peminjaman.peminjamanStatus))
                .font(.system(size: 15, design: .rounded))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.groupColor))
    }
}

struct ListPeminjamanView: View {
    @ObservedObject var peminjamanVM: PeminjamanViewModel
    var body: some View {
        ScrollView {
            ForEach (peminjamanVM.filterPeminjaman(), id:\.id) {
                key in
                VStack(spacing: 10) {
                    ListPeminjamanContentView(
                        peminjaman: key)
                }
                .contextMenu {
                    Button {
                        peminjamanVM.fillForm(model: key)
                    } label: {
                        Label("Ubah Peminjaman", systemImage: "square.and.pencil")
                    }
                    Button {
                        peminjamanVM.fillForm(model: key)
                    } label: {
                        Label("Selesaikan Peminjaman", systemImage: "checkmark.circle ")
                    }
                    Divider()
                    Button {
                        peminjamanVM.deleteById(model: key)
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

struct ListPeminjamanView_Previews: PreviewProvider {
    static var previews: some View {
        ListPeminjamanView(peminjamanVM: PeminjamanViewModel())
    }
}
