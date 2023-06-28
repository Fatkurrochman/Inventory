//
//  BarangView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct BarangView: View {
    @EnvironmentObject var barangVM: BarangViewModel
    
    var body: some View {
        VStack {
            ListBarangView(barangVM: barangVM)
        }
        .navigationTitle("Barang")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    barangVM.setDefaultForm()
                    barangVM.status = "create"
                    barangVM.isPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $barangVM.isPresented) {
            BarangFormView(barangVM: barangVM, isPresented: $barangVM.isPresented)
        }
        .onAppear {
            barangVM.fetchBarang()
               }

    }
}

struct BarangView_Previews: PreviewProvider {
    static var previews: some View {
        BarangView()
            .environmentObject(BarangViewModel())
    }
}
