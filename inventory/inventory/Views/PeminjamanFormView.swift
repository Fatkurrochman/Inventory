//
//  PeminjamanFormView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct PeminjamanFormView: View {
    @Binding var isPresented: Bool
    @ObservedObject var peminjamanVM: PeminjamanViewModel
    let dateFormatter = DateFormatter()
    func actionDone() {
        if peminjamanVM.status == "edit" {
           peminjamanVM.edit()
            closeModal()
        } else {
            peminjamanVM.create()
            closeModal()
        }
        
    }
    func actionCancel() {
        isPresented.toggle()
    }
    
    func closeModal() {
        if(!peminjamanVM.isErrorForm && !peminjamanVM.isEmptyForm){
            isPresented.toggle()
        }
    }
    
    func barangOnTap(barang: ProductModel) {
        peminjamanVM.barangName = barang.name
        peminjamanVM.barangId = String(barang.id)
    }
    func karyawanListOnTap(karyawan: KaryawanModel) {
        peminjamanVM.karyawanName = karyawan.name
        peminjamanVM.karyawanId = "\(karyawan.id)"
        peminjamanVM.karyawanBadge = karyawan.badge_id
        peminjamanVM.karyawanEmail = karyawan.email
        peminjamanVM.karyawanDepartement = ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Karyawan")
                    .font(.system(.caption, design: .rounded))) {
                        HStack {
                            if #available(iOS 16.0, *) {
                                Picker(selection: $peminjamanVM.karyawanId, label: Text("\(peminjamanVM.karyawanName)")
                                        .font(.system(.callout, design: .rounded))) {
                                            ForEach(peminjamanVM.employeeList, id:\.id) { key in
                                                Text("\(key.name) (\(key.badge_id))")
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                karyawanListOnTap(karyawan: key)
                                            }
                                    }
                                }
                                                    .pickerStyle(.navigationLink)
                                                } else {
                                                    Picker(selection: $peminjamanVM.karyawanId, label: Text("\(peminjamanVM.karyawanName)")
                                                            .font(.system(.callout, design: .rounded))) {
                                                                ForEach(peminjamanVM.employeeList, id:\.id) { key in
                                                                    Text("\(key.name) (\(key.badge_id))")
                                                                .contentShape(Rectangle())
                                                                .onTapGesture {
                                                                    karyawanListOnTap(karyawan: key)
                                                                }
                                                        }
                                                    }
                                                }
                     
                                
                      
                        }
                }
                Section {
                    TextField("Badge", text: $peminjamanVM.karyawanBadge)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                    TextField("Departemen", text: $peminjamanVM.karyawanDepartement)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                    TextField("Email", text: $peminjamanVM.karyawanEmail)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                }
                
                Section(header: Text("Data Barang")
                    .font(.system(.caption, design: .rounded))) {
                        if #available(iOS 16.0, *) {
                            Picker(selection: $peminjamanVM.barangId, label: Text("\(peminjamanVM.barangName)")
                                    .font(.system(.callout, design: .rounded))) {
                                        ForEach(peminjamanVM.productList, id:\.id) { key in
                                            PeminjamanListBarangContentView(barang: key)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            barangOnTap(barang: key)
                                        }
                                }
                            }
                                                .pickerStyle(.navigationLink)
                                            } else {
                                                Picker(selection: $peminjamanVM.barangId, label: Text("\(peminjamanVM.barangName)")
                                                        .font(.system(.callout, design: .rounded))) {
                                                            ForEach(peminjamanVM.productList, id:\.id) { key in
                                                                PeminjamanListBarangContentView(barang: key)
                                                            .contentShape(Rectangle())
                                                            .onTapGesture {
                                                                barangOnTap(barang: key)
                                                            }
                                                    }
                                                }
                                            }
                  
                        
                        TextField("Jumlah", text: $peminjamanVM.qty)
                            .font(.system(.callout, design: .rounded))
                }
                Section(header: Text("Detail Tanggal Peminjaman")
                    .font(.system(.caption, design: .rounded))) {
                        DatePicker("Mulai", selection: (
                             $peminjamanVM.startDate
                            ), displayedComponents: .date)
                            .font(.system(.callout, design: .rounded))
                        
                        DatePicker("Berakhir", selection: $peminjamanVM.endDate, in: peminjamanVM.startDate..., displayedComponents: .date)
                            .font(.system(.callout, design: .rounded))
                }
                if(peminjamanVM.isEmptyForm){
                    Text("Mohon untuk mengisi semua data Peminjaman terlebih dahulu")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }
                if(peminjamanVM.isErrorForm){
                    Text("Gagal Menambahkan Peminjaman")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }
            }
            .onAppear {
                peminjamanVM.fetchEmployee()
                peminjamanVM.fetchProductList()
            }
            .navigationBarTitle(peminjamanVM.status == "edit" ? "Edit Peminjaman" : "Tambah Peminjaman", displayMode: .inline)
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
