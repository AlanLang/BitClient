//
//  ServiceEditViewModel.swift
//  BitClient
//
//  Created by Alan on 2021/11/6.
//

import SwiftUI

class ServiceEditViewModel: ObservableObject {
    @Published var url: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    init (){
        self.url = UserDefaults.standard.string(forKey: "service.url") ?? ""
        self.password = UserDefaults.standard.string(forKey: "service.password") ?? ""
        self.username = UserDefaults.standard.string(forKey: "service.username") ?? ""
    }
    
    func save(){
        UserDefaults.standard.set(self.url, forKey: "service.url")
        UserDefaults.standard.set(self.password, forKey: "service.password")
        UserDefaults.standard.set(self.username, forKey: "service.username")
    }
    
    func test(){
        let messageTitle = "测试连接"
        NetworkAPi.login(bitService: BitService(url: self.url, username: self.username, password: self.password)) {
            result in
            switch result {
                case let .success(data):
                    switch data {
                        case "Ok.":
                            Message.success(message: "连接成功", title: messageTitle)
                        case "Fails.":
                            Message.warning(message: "用户名或密码错误", title: messageTitle)
                        case "Not Found":
                            Message.warning(message: "请求地址有误", title: messageTitle)
                        default:
                            Message.warning(message: data, title: messageTitle)
                        }
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
        }
    }
}
