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
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    
    func actionDone() {
        if karyawanVM.status == "edit" {
            karyawanVM.edit()
         
        } else {
            karyawanVM.create()
        }
        closeModal()
    }
    
    func closeModal() {
        if(!karyawanVM.isErrorForm && !karyawanVM.isEmptyForm){
            isPresented.toggle()
            karyawanVM.fetchKaryawan()
       
        }
    }
    func actionCancel() {
        isPresented.toggle()
    }
    
    func departemenOnTap(departemen: DepartemenModel) {
        karyawanVM.depatment_name = departemen.name
        karyawanVM.department = "\(departemen.id)"
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
                                if #available(iOS 16.0, *) {
                                    Picker(selection: $karyawanVM.department, label: Text(karyawanVM.depatment_name)
                                            .font(.system(.callout, design: .rounded))) {
                                                ForEach(karyawanVM.departementList, id:\.id) { key in
                                                    Text(key.name)
                                                .contentShape(Rectangle())
                                                .onTapGesture {
                                                    departemenOnTap(departemen: key)
                                                }
                                            .navigationTitle(karyawanVM.status == "edit" ? "Edit Karyawan" : "Tambah Karyawan")
                                        }
                                    }
                                    .font(.system(.callout, design: .rounded))
                                                        .pickerStyle(.navigationLink)
                                                    } else {
                                                        Picker(selection: $karyawanVM.department, label: Text(karyawanVM.depatment_name)
                                                                .font(.system(.callout, design: .rounded))) {
                                                                    ForEach(karyawanVM.departementList, id:\.id) { key in
                                                                        Text(key.name)
                                                                    .contentShape(Rectangle())
                                                                    .onTapGesture {
                                                                        departemenOnTap(departemen: key)
                                                                    }
                                                                .navigationTitle(karyawanVM.status == "edit" ? "Edit Karyawan" : "Tambah Karyawan")
                                                            }
                                                        }
                                                        .font(.system(.callout, design: .rounded))
                                                    }
                                
                              
                                TextField("Email", text: $karyawanVM.email)
                        .font(.system(.callout, design: .rounded))
                                if(karyawanVM.isEmptyForm){
                                    Text("Mohon untuk mengisi semua data Karyawan terlebih dahulu")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14))
                                }
                                if(karyawanVM.isErrorForm){
                                    Text("Gagal Menambahkan Karyawan")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14))
                                }
                }
            }
            .onAppear {
                karyawanVM.fetchDepartemen()
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

