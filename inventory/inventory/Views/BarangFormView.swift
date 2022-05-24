//
//  BarangFormView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct BarangFormView: View {
    @ObservedObject var barangVM: BarangViewModel
    @Binding var isPresented: Bool
    
    func actionDone() {
        if barangVM.status == "edit" {
            barangVM.edit()
        } else {
            barangVM.create()
        }
        isPresented.toggle()
    }
    func actionCancel() {
        isPresented.toggle()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Barang")
                    .font(.system(.caption, design: .rounded))) {
                        TextField("Kode Barang", text: $barangVM.code)
                            .font(.system(.callout, design: .rounded))
                        TextField("Nama Barang", text: $barangVM.name)
                            .font(.system(.callout, design: .rounded))
                        TextField("Jumlah Barang", text: $barangVM.qty)
                            .font(.system(.callout, design: .rounded))
                }
            }
            .navigationBarTitle(barangVM.status == "edit" ? "Edit Barang" : "Tambah Barang", displayMode: .inline)
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

//struct BarangFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarangFormView()
//    }
//}
