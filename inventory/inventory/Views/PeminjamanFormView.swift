//
//  PeminjamanFormView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct PeminjamanFormView: View {
    @State var text: String = ""
    @State var status: String = ""
    @Binding var isPresented: Bool
    @ObservedObject var peminjamanVM: PeminjamanViewModel
    
    func actionDone() {
        isPresented.toggle()
    }
    func actionCancel() {
        isPresented.toggle()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Karyawan")
                    .font(.system(.caption, design: .rounded))) {
                        TextField("Kode Barang", text: $text)
                            .font(.system(.callout, design: .rounded))
                }
                Section(header: Text("Data Baranng")
                    .font(.system(.caption, design: .rounded))) {
                        TextField("Kode Barang", text: $text)
                            .font(.system(.callout, design: .rounded))
                        TextField("Jumlah", text: $text)
                            .font(.system(.callout, design: .rounded))
                }
                Section(header: Text("Detail Tanggal")
                    .font(.system(.caption, design: .rounded))) {
                        DatePicker("Peminjaman", selection: (
                            $peminjamanVM.startDate
                            ), displayedComponents: .date)
                            .font(.system(.callout, design: .rounded))
                        
                        DatePicker("Pengembalian", selection: $peminjamanVM.startDate, in: peminjamanVM.endDate..., displayedComponents: .date)
                            .font(.system(.callout, design: .rounded))
                }
            }
            .navigationBarTitle(status == "edit" ? "Edit Peminjaman" : "Tambah Peminjaman", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: actionCancel, label: {
                        Text("Cancel")
                            .font(.system(.callout, design: .rounded))
                }),
                trailing: Button(action: actionDone, label: {
                        Text("Done")
                            .font(.system(.callout, design: .rounded))
                })
            )
        }
    }
}

//struct PeminjamanFormView_Previews: PreviewProvider {
//    @State var isPresented = false
//    static var previews: some View {
//        PeminjamanFormView(isPresented: $isPresented, peminjamanVM: PeminjamanViewModel())
//    }
//}
