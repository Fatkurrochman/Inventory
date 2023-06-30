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
            closeModal()
        } else {
            barangVM.create()
            closeModal()
        }
      
        
    }
    func closeModal(){
        if(!barangVM.isErrorForm && !barangVM.isEmptyForm){
            isPresented.toggle()
        }
      
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
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                        if(barangVM.isEmptyForm){
                            Text("Mohon untuk mengisi semua data barang terlebih dahulu")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                        if(barangVM.isErrorForm){
                            Text("Gagal Menambahkan Barang")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
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


