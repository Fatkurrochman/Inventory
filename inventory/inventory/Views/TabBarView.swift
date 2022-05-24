//
//  TabBarView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    @ObservedObject var barangVM: BarangViewModel = BarangViewModel()
    @ObservedObject var karyawanVM: KaryawanViewModel = KaryawanViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BarangView().tabItem {
//                Image("cube.box")
                Text("Barang")
            }.tag(1).environmentObject(barangVM)
            KaryawanView().tabItem {
//                Image("person.3.fill")
                Text("Karyawan")
            }.tag(2).environmentObject(karyawanVM)
        }
            
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
