//
//  KaryawanFormView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct KaryawanFormView: View {
    @ObservedObject var karyawanVM: KaryawanViewModel
    @Binding var isPresented: Bool
    
    func actionDone() {
        if karyawanVM.status == "edit" {
            karyawanVM.edit()
        } else {
            karyawanVM.create()
        }
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
                                TextField("No. Badge", text: $karyawanVM.badge_id)
                        .font(.system(.callout, design: .rounded))
                                TextField("Nama Karyawan", text: $karyawanVM.name)
                        .font(.system(.callout, design: .rounded))
                                TextField("Departemen", text: $karyawanVM.department)
                        .font(.system(.callout, design: .rounded))
                                TextField("Email", text: $karyawanVM.email)
                        .font(.system(.callout, design: .rounded))
                }
            }
            .navigationBarTitle(karyawanVM.status == "edit" ? "Edit Karyawan" : "Tambah Karyawan", displayMode: .inline)
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

//struct KaryawanFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        KaryawanFormView()
//    }
//}
