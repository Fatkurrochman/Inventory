//
//  PeminjamanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct PeminjamanView: View {
    @EnvironmentObject var peminjamanVM: PeminjamanViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ListPeminjamanView(peminjamanVM: peminjamanVM)
            }
            .navigationTitle("Peminjaman")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        peminjamanVM.setDefaultForm()
                        peminjamanVM.status = "create"
                        peminjamanVM.isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $peminjamanVM.isPresented) {
                PeminjamanFormView(isPresented: $peminjamanVM.isPresented, peminjamanVM: peminjamanVM)
            }
        }
    }
}

struct PeminjamanView_Previews: PreviewProvider {
    static var previews: some View {
        PeminjamanView()
    }
}
