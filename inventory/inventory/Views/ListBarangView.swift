//
//  ListBarangView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct ListBarangContentView: View {
    var barang: ProductModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(barang.name)
                    .font(.system(size: 15, design: .rounded))
                Text(barang.code)
                .font(.system(size: 13, design: .rounded))
            }
            Spacer()
            Text(String(barang.qty))
                .font(.system(size: 15, design: .rounded))
        }
     
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.buttonDashboard))
    }
}

struct ListBarangView: View {
    @ObservedObject var barangVM: BarangViewModel
    
    var body: some View {
        ScrollView { 
            ForEach (barangVM.barang, id:\.id) { key in
                VStack(spacing: 10) {
                    ListBarangContentView(
                        barang: key)
                }
                .contextMenu {
                    Button {
                        barangVM.fillForm(model: key)
                    } label: {
                        Label("Ubah Barang", systemImage: "square.and.pencil")
                    }
                    Divider()
                    Button {
                        barangVM.openAlert(model:key)
                    } label: {
                        Text("Hapus")
                        Image(systemName: "trash")
                    }
                 
                }
                .alert("Delete Item ?", isPresented: $barangVM.showingAlertDelete) {
                  
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive, action: {
                        barangVM.deleteById()
                    })
                        }
            message:  {
                  Text("Are you sure want to delete this item ?")
                }
                .padding(.horizontal)
           
            }
        }
    }
}


struct PeminjamanListBarangContentView: View {
    var barang: ProductModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(barang.name)
                    .font(.system(size: 15, design: .rounded))
                Text(barang.code)
                .font(.system(size: 13, design: .rounded))
            }
            Spacer()
            Text(String(barang.qty))
                .font(.system(size: 15, design: .rounded))
        }
        .padding()
    }

}

