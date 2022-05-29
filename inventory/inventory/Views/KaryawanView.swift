//
//  KaryawanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct KaryawanView: View {
    @EnvironmentObject var karyawanVM: KaryawanViewModel
    
    var body: some View {
        VStack {
            ListKaryawanView(karyawanVM: karyawanVM)
        }
        .navigationTitle("Karyawan")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    karyawanVM.setDefaultForm()
                    karyawanVM.status = "create"
                    karyawanVM.isPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $karyawanVM.isPresented) {
            KaryawanFormView(karyawanVM: karyawanVM, isPresented: $karyawanVM.isPresented)
        }
    }
}

struct KaryawanView_Previews: PreviewProvider {
    static var previews: some View {
        KaryawanView()
    }
}
