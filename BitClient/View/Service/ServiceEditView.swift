//
//  ServiceEditView.swift
//  BitClient
//
//  Created by Alan on 2021/11/6.
//

import SwiftUI

struct ServiceEditView: View {
    @ObservedObject private var serviceEditViewModel: ServiceEditViewModel
    
    init(){
        UITableView.appearance().sectionFooterHeight = 8
        serviceEditViewModel = ServiceEditViewModel()
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        Form {
            Section(){
                TextField("服务器地址", text: $serviceEditViewModel.url)
                TextField("用户名", text: $serviceEditViewModel.username)
                SecureField("密码",text: $serviceEditViewModel.password)
                Button("测试连接", action: {
                    if (serviceEditViewModel.url == "") {
                        Message.warning(message: "服务器地址不能为空")
                    } else if (serviceEditViewModel.username == "") {
                        Message.warning(message: "用户名不能为空")
                    } else if (serviceEditViewModel.password == "") {
                        Message.warning(message: "密码不能为空")
                    } else {
//                        serviceEditViewModel.test()
                    }
                })
            }
        }
        .navigationBarTitle(Text("服务器配置"))
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        serviceEditViewModel.save()
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "externaldrive.badge.checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 5)
                            .foregroundColor(.blue)
                    })
                }
            }
        }
    }
}

struct ServiceEditView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceEditView()
    }
}
