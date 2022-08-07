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
    
    func actionDone() {
        if peminjamanVM.status == "edit" {
//            peminjamanVM.edit()
        } else {
            peminjamanVM.create()
        }
        isPresented.toggle()
    }
    func actionCancel() {
        isPresented.toggle()
    }
    func barangOnTap(barang: BarangModel) {
        peminjamanVM.barangName = barang.name
        peminjamanVM.barangId = barang.barang
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Karyawan")
                    .font(.system(.caption, design: .rounded))) {
                        HStack {
                            TextField("No Badge", text: $peminjamanVM.karyawanBadge)
                                .font(.system(.callout, design: .rounded))
                                
                            HStack {
                                Text("Check")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 30.0)
                                            .foregroundColor(InventoryHelper.buttonDashboard)
                                    )
                            }.onTapGesture {
                                peminjamanVM.checkKaryawan()
                            }
                        }
                }
                Section {
                    TextField("Nama Karyawann", text: $peminjamanVM.karyawanName)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                    TextField("Departemen", text: $peminjamanVM.karyawanDepartement)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                    TextField("Email", text: $peminjamanVM.karyawanEmail)
                            .font(.system(.callout, design: .rounded))
                            .disabled(true)
                }
                
                Section(header: Text("Data Baranng")
                    .font(.system(.caption, design: .rounded))) {
                        Picker(selection: $peminjamanVM.barangId, label: Text(peminjamanVM.barangName)
                                .font(.system(.callout, design: .rounded))) {
                                    ForEach(peminjamanVM.barang, id:\.id) { key in
                                        PeminjamanListBarangContentView(barang: key)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        barangOnTap(barang: key)
                                    }
                                .navigationTitle("Barang")
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

//struct PeminjamanFormView_Previews: PreviewProvider {
//    @State var isPresented = false
//    static var previews: some View {
//        PeminjamanFormView(isPresented: $isPresented, peminjamanVM: PeminjamanViewModel())
//    }
//}
