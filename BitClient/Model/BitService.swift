//
//  BitService.swift
//  BitClient
//
//  Created by Alan on 2021/11/7.
//

import Foundation
class BitService {
    var url: String
    var username: String
    var password: String
    
    init (){
        self.url = UserDefaults.standard.string(forKey: "service.url") ?? ""
        self.password = UserDefaults.standard.string(forKey: "service.password") ?? ""
        self.username = UserDefaults.standard.string(forKey: "service.username") ?? ""
    }
    
    init(url: String, username: String, password: String){
        self.url = url
        self.username = username
        self.password = password
    }
    
    func updateService(url: String, username: String, password: String){
        self.url = url
        self.username = username
        self.password = password
    }
    
    func login(completion: @escaping (Bool) -> Void){
        if(self.url == "") {
            Message.warning(message: "请先配置服务器地址")
            completion(false)
            return
        }
        NetworkAPi.login(bitService: BitService(url: self.url, username: self.username, password: self.password)) {
            result in
            switch result {
                case let .success(data):
                    switch data {
                        case "Ok.":
                        completion(true)
                        case "Fails.":
                            Message.warning(message: "用户名或密码错误")
                            completion(false)
                        default:
                            Message.warning(message: data)
                            completion(false)
                        }
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
                    completion(false)
            }
        }
    }
    
    func delete(id: String, deleteFiles: Bool){
        NetworkAPi.delete(id: id, deleteFiles: deleteFiles) {result in
            switch result {
                case .success(_):
                    Message.success(message: "删除成功", title: "删除")
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
        }
    }
    
    func pause(id: String) {
        NetworkAPi.pause(id: id) {result in
            switch result {
                case .success(_):
                    Message.success(message: "成功", title: "暂停")
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
        }
    }
    
    func resume(id: String) {
        NetworkAPi.resume(id: id){result in
            switch result {
                case .success(_):
                    Message.success(message: "成功", title: "继续")
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
        }
    }

    func toggleSpeedLimitsMode() {
        NetworkAPi.toggleSpeedLimitsMode(){result in
            switch result {
                case .success(_):
                     Message.success(message: "修改成功", title: "限速设置")
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
        }
    }
}
