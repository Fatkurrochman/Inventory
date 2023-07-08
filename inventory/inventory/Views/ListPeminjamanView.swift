//
//  ListPeminjamanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct ListPeminjamanContentView: View {
    var peminjaman: PeminjamanModel
    var products: [ProductModel]
    var employees: [KaryawanModel]
    
    func generateEmployeeName(employee_id: Int) -> String {
        let emp_ids = self.employees.filter({ e in
            e.id == employee_id
        })
        if emp_ids.count > 0 {
            return emp_ids[0].name
        } else {
            return ""
        }
    }
    
    func generateProductName(product_id: Int) -> String {
        let prod_ids = self.products.filter({ p in
            p.id == product_id
        })
        if prod_ids.count > 0 {
            return prod_ids[0].name
        } else {
            return ""
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(generateProductName(product_id: peminjaman.product_id))
                    .font(.system(size: 15, design: .rounded))
                Text(generateEmployeeName(employee_id: peminjaman.employee_id))
                    .font(.system(size: 13, design: .rounded))
                HStack {
                    Text("\(peminjaman.formattedStartDate.formatted(date: .numeric, time: .omitted)) -")
                        .font(.system(size: 13, design: .rounded))
                    Text("\(peminjaman.formattedEndDate.formatted(date: .numeric, time: .omitted))")
                    .font(.system(size: 13, design: .rounded))
                }
            }
            Spacer()
            Text(peminjaman.statusFormatted)
                .font(.system(size: 15, design: .rounded))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.buttonDashboard))
    }
}

struct ListPeminjamanView: View {
    @ObservedObject var peminjamanVM: PeminjamanViewModel
    var body: some View {
        ScrollView {
            ForEach (peminjamanVM.peminjaman, id:\.id) {
                key in
                VStack(spacing: 10) {
                    ListPeminjamanContentView(peminjaman: key, products: peminjamanVM.productList, employees: peminjamanVM.employeeList)
                }
                .contextMenu {
                    Button {
                        peminjamanVM.onComplatePeminjaman(model: key)
                    } label: {
                        Label("Selesaikan Peminjaman", systemImage: "checkmark.circle")
                    }
                    Button {
                        peminjamanVM.openAlert(model: key)
                    } label: {
                        Text("Cancel Peminjaman")
                        Image(systemName: "trash")
                    }
                }
                .alert("Order tidak dapat di cancel atau di selesaikan", isPresented: $peminjamanVM.showingAlertFailed, actions: {
                    Button("Close", role: .cancel) { }
                })
                .alert("Cancel Loan ?", isPresented: $peminjamanVM.showingAlertDelete) {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes", role: .destructive, action: {
                        peminjamanVM.cancel()
                    })
                }
                message:  {
                  Text("Are you sure want to cancel this Loan ?")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ListPeminjamanView_Previews: PreviewProvider {
    static var previews: some View {
        ListPeminjamanView(peminjamanVM: PeminjamanViewModel())
    }
}
