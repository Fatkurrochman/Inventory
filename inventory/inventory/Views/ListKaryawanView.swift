//
//  ListKaryawanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct ListKaryawanContentView: View {
    var karyawan: KaryawanModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(karyawan.name)
                    .font(.system(size: 15, design: .rounded))
                Text(karyawan.badge_id + " - " + karyawan.department)
                    .font(.system(size: 13, design: .rounded))
                Text(karyawan.email)
                    .font(.system(size: 13, design: .rounded))
//                    Text("Departemen")
//                        .font(.system(size: 13, design: .rounded))
//                        .foregroundColor(Color.init(.systemGray))
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.groupColor))
    }
}

struct ListKaryawanView: View {
    @ObservedObject var karyawanVM: KaryawanViewModel
    var body: some View {
        ScrollView {
            ForEach (karyawanVM.filterKaryawan(), id:\.id) {
                key in
                VStack(spacing: 10) {
                    ListKaryawanContentView(
                        karyawan: key)
                }
                .contextMenu {
                    Button {
                        karyawanVM.fillForm(model: key)
                    } label: {
                        Label("Ubah Karyawan", systemImage: "square.and.pencil")
                    }
                    Divider()
                    Button {
                        karyawanVM.deleteById(model: key)
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

//struct ListKaryawanView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListKaryawanView()
//    }
//}
