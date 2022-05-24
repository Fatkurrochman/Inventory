//
//  TabBarView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    @ObservedObject var karyawan: KaryawanViewModel = KaryawanViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BarangView().tabItem {
//                Image("message")
                Text("Barang")
            }.tag(2)
            KaryawanView().tabItem {
//                Image("person.3.fill")
                Text("Karyawan")
            }.tag(1).environmentObject(karyawan)
        }
            
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
