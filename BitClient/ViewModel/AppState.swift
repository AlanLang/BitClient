//
//  AppState.swift
//  BitClient
//
//  Created by alan lang on 2023/1/20.
//

import Foundation
import Network
class AppState: ObservableObject {
    @Published var url: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLogin: Bool = false
    
    init (){
        self.url = UserDefaults.standard.string(forKey: "service.url") ?? ""
        self.password = UserDefaults.standard.string(forKey: "service.password") ?? ""
        self.username = UserDefaults.standard.string(forKey: "service.username") ?? ""
        self.isLogin = UserDefaults.standard.bool(forKey: "app.islogin")
    }
    
    func test(completion: @escaping (Bool) -> Void){
        let messageTitle = "登录提示"
        NetworkAPi.login(bitService: BitService(url: self.url, username: self.username, password: self.password)) {
            result in
            switch result {
                case let .success(data):
                    switch data {
                        case "Ok.":
                            completion(true);
                            Message.success(message: "连接成功", title: messageTitle)
                        case "Fails.":
                            completion(false);
                            Message.warning(message: "用户名或密码错误", title: messageTitle)
                        case "Not Found":
                            completion(false);
                            Message.warning(message: "请求地址有误", title: messageTitle)
                        default:
                            completion(false);
                            Message.warning(message: data, title: messageTitle)
                        }
                case let .failure(error):
                    completion(false);
                    Message.error(message: error.localizedDescription)
            }
        }
    }
    
    func requestNetworkPermission(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network is available")
                completion(true)
            } else {
                print("Network is not available")
                completion(false)
            }
        }
            
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func save(){
        self.isLogin = true
        UserDefaults.standard.set(self.url, forKey: "service.url")
        UserDefaults.standard.set(self.password, forKey: "service.password")
        UserDefaults.standard.set(self.username, forKey: "service.username")
        UserDefaults.standard.set(true, forKey: "app.islogin")
    }
    
    func logOut(){
        self.isLogin = false
        UserDefaults.standard.set(false, forKey: "app.islogin")
    }
}
