//
//  ListKaryawanView.swift
//  inventory
//
//  Created by Rinaldi on 24/05/22.
//

import SwiftUI

struct ListKaryawanContentView: View {
    var karyawan: KaryawanModel
    var departments: [DepartemenModel]
    
    func generateDepartmentName(department_id: Int) -> String {
        let dep_ids = self.departments.filter({ d in
            d.id == department_id
        })
        if dep_ids.count > 0 {
            return dep_ids[0].name
        } else {
            return ""
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(karyawan.name)
                    .font(.system(size: 15, design: .rounded))
                Text(karyawan.badge_id + " - " + "\(generateDepartmentName(department_id: karyawan.department_id))")
                    .font(.system(size: 13, design: .rounded))
                Text(karyawan.email)
                    .font(.system(size: 13, design: .rounded))
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(InventoryHelper.buttonDashboard))
    }
}

struct ListKaryawanView: View {
    @ObservedObject var karyawanVM: KaryawanViewModel
    var body: some View {
        ScrollView {
            ForEach (karyawanVM.karyawan, id:\.id) {
                key in
                VStack(spacing: 10) {
                    ListKaryawanContentView(karyawan: key, departments: karyawanVM.departementList)
                }
                .contextMenu {
                    Button {
                        karyawanVM.fillForm(model: key)
                    } label: {
                        Label("Ubah Karyawan", systemImage: "square.and.pencil")
                    }
                    Divider()
                    Button {
                        karyawanVM.openAlert(model:key)
                    } label: {
                        Text("Hapus")
                        Image(systemName: "trash")
                    }
                }
                .alert("Delete Employee ?", isPresented: $karyawanVM.showingAlertDelete) {
                  
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive, action: {
                        karyawanVM.deleteById()
                    })
                        }
            message:  {
                  Text("Are you sure want to delete this Employee ?")
                }
                .padding(.horizontal)
            }
        }
    }
}



