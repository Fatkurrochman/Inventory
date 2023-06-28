//
//  BarangFormView.swift
//  inventory
//
//  Created by Rasyid Khaikal on 24/05/22.
//

import SwiftUI

struct AddUserFormView: View {
    @ObservedObject var userVM: UserViewModel
    @Binding var isPresented: Bool
    
    func actionDone() {

        userVM.create()
            closeModal()
        
      
        
    }
    func closeModal(){
        if(!userVM.isErrorForm && !userVM.isEmptyForm && !userVM.isPasswordMatch){
            isPresented.toggle()
        
            print("masuk1")
        }
      
    }
    func actionCancel() {
        isPresented.toggle()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Pengguna")
                    .font(.system(.caption, design: .rounded))) {
                        TextField("Username", text: $userVM.username)
                            .font(.system(.callout, design: .rounded))
                        SecureField("Password", text: $userVM.password)
                            .font(.system(.callout, design: .rounded))
                        SecureField("Confirm Password", text: $userVM.confirmPassword)
                            .font(.system(.callout, design: .rounded))
                        if(userVM.isEmptyForm){
                            Text("Mohon untuk mengisi semua data Pengguna terlebih dahulu")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                        if(userVM.isErrorForm){
                            Text("Gagal Menambahkan Pengguna")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                        if(userVM.isPasswordMatch){
                            Text("Password Tidak Sama")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                        
                        
                       
                }
            }
          
            .navigationBarTitle("Tambah Pengguna", displayMode: .inline)
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


