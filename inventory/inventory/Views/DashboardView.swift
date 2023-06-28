//
//  DashboardView.swift
//  inventory
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    @ObservedObject var barangVM: BarangViewModel = BarangViewModel()
    @ObservedObject var karyawanVM: KaryawanViewModel = KaryawanViewModel()
    @ObservedObject var peminjamanVM: PeminjamanViewModel = PeminjamanViewModel()
    
    @ObservedObject var addUserVM:UserViewModel = UserViewModel()
    
    @State var isBarang: Bool = false
    @State var isKaryawan: Bool = false
    @State var isPeminjaman: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello, \(loginVM.username)") 
                            .font(.title)
                        Text("Welcome Back!")
                            .font(.title3)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.left.circle.fill")
                        Text("Logout")
                            .font(.footnote)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(InventoryHelper.buttonDashboard)
                    ).onTapGesture {
                        loginVM.logout()
                    }
                }
                .padding()
                
                Button {
                    isBarang = true
                } label: {
                    NavigationLink(
                        destination: BarangView().environmentObject(barangVM), isActive: $isBarang) {
                        HStack {
//                            Image("Barang")
//                                .resizable()
//                                .frame(width: 50, height: 50, alignment: .center)
//                                .foregroundColor(.black)
//                                .padding()
                            Image(systemName: "shippingbox")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.black)
                                .padding()
                            Text("Barang")
                                .font(.title)
                                .foregroundColor(.black)
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(InventoryHelper.buttonDashboard)
                        )
                        .padding()
                     }
                    .contentShape(Rectangle())
                }
                
                Button {
                    isKaryawan = true
                } label: {
                    NavigationLink(
                        destination: KaryawanView().environmentObject(karyawanVM), isActive: $isKaryawan) {
                        HStack {
//                            Image("Karyawan")
//                                .resizable()
//                                .frame(width: 50, height: 50, alignment: .center)
//                                .foregroundColor(.black)
//                                .padding()
                            Image(systemName: "person.3")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.black)
                                .padding()
                            Text("Karyawan")
                                .font(.title)
                                .foregroundColor(.black)
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(InventoryHelper.buttonDashboard)
                        ).padding()
                     }
                    .contentShape(Rectangle())
                }
                
                Button {
                    isPeminjaman = true
                } label: {
                    NavigationLink(
                        destination: PeminjamanView().environmentObject(peminjamanVM), isActive: $isPeminjaman) {
                        HStack {
                            Image(systemName: "list.clipboard")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.black)
                                .padding()
//                            Image("Peminjaman")
//                                .resizable()
//                                .frame(width: 50, height: 50, alignment: .center)
//                                .foregroundColor(.black)
//                                .padding()
                            Text("Peminjaman")
                                .font(.title)
                                .foregroundColor(.black)
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(InventoryHelper.buttonDashboard)
                        ).padding()
                     }
                    .contentShape(Rectangle())
                }
                Button {
                    addUserVM.isPresented.toggle()
                } label: {
             
                        HStack {
                            Image(systemName: "person.fill.badge.plus")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.black)
                                .padding()
                            Text("Pengguna")
                                .font(.title)
                                .foregroundColor(.black)
                            Spacer()
                        }.background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(InventoryHelper.buttonDashboard)
                        ).padding()
                     
                    .contentShape(Rectangle())
                }
                
                Spacer()
            }
            }
            .sheet(isPresented: $addUserVM.isPresented) {
                AddUserFormView(userVM: addUserVM, isPresented: $addUserVM.isPresented)
            }
            .navigationTitle("Dashboard")
            .navigationBarHidden(true)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(LoginViewModel())
            
    }
}
