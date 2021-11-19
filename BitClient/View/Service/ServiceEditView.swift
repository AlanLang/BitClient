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
            }
            Section(header: Button(action: {
                serviceEditViewModel.test()
            }) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "personalhotspot")
                        Text("测试连接")
                        Spacer()
                    }
                    Spacer()
                }
                .foregroundColor(.black)
                .background(Color.white)
                .frame(height: 35)
            }){}
            Section(header: Button(action: {
                if (serviceEditViewModel.url == "") {
                    Message.warning(message: "服务器地址不能为空")
                } else if (serviceEditViewModel.username == "") {
                    Message.warning(message: "用户名不能为空")
                } else if (serviceEditViewModel.password == "") {
                    Message.warning(message: "密码不能为空")
                } else {
                    serviceEditViewModel.save()
                    self.mode.wrappedValue.dismiss()
                }
                
            }) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "simcard")
                        Text("保存设置")
                        Spacer()
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .frame(height: 35)
            }){}.offset(y: -20)
        }
        .navigationBarTitle(Text("服务器配置"))
    }
}

struct ServiceEditView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceEditView()
    }
}
