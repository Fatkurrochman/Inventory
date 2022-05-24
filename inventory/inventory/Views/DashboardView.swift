//
//  DashboardView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            HStack {
                Image("Barang")
                    .frame(width: 92, height: 75)
                    .padding()
                Text("Barang")
                    .font(.title)
                Spacer()
            }.background(
                RoundedRectangle(cornerRadius: 30.0)
                    .foregroundColor(InventoryHelper.buttonDashboard)
            )
            .padding()
            HStack {
                Image("Karyawan")
                    .frame(width: 81, height: 81)
                    .padding()
                Text("Karyawan")
                    .font(.title)
                Spacer()
            }.background(
                RoundedRectangle(cornerRadius: 30.0)
                    .foregroundColor(InventoryHelper.buttonDashboard)
            ).padding()
            
            HStack {
                Image("Peminjaman")
                    .frame(width: 100, height: 100)
                    .padding()
                Text("Peminjaman")
                    .font(.title)
                Spacer()
            }.background(
                RoundedRectangle(cornerRadius: 30.0)
                    .foregroundColor(InventoryHelper.buttonDashboard)
            ).padding()
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
