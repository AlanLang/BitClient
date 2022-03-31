//
//  AddTorrentLinkFormModel.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//
import SwiftUI

class AddTorrentLinkFormModel: ObservableObject {
    // 下载地址
    @Published var urls: String
    // 按顺序下载
    @Published var sequentialDownload: Bool
    @Published var autoTMM: Bool
    @Published var savepath: String
    // cookie
    @Published var cookie: String
    // 重命名
    @Published var rename: String
    @Published var category: String?
    // 添加后暂停
    @Published var paused: Bool
    // 保留顶层文件
    @Published var root_folder: Bool
    // 下载速度限制
    @Published var dlLimit: String
    // 上传速度限制
    @Published var upLimit: String
    // 跳过哈希值
    @Published var skip_checking: Bool
    // 先下载首位文件块
    @Published var firstLastPiecePrio: Bool
    
    init(savepath: String) {
        self.urls = ""
        self.sequentialDownload = false
        self.autoTMM = false
        self.savepath = savepath
        self.cookie = ""
        self.rename = ""
        self.category = nil
        self.paused = false
        self.root_folder = true
        self.dlLimit = ""
        self.upLimit = ""
        self.skip_checking = false
        self.firstLastPiecePrio = false
        NetworkAPi.preferences() { result in
            switch result {
                case let .success(data):
                    self.savepath = data.savePath
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
            }
                
        }
    }
    
    func download(completion: @escaping (Bool) -> Void){
        NetworkAPi.download(model: self) {result in
            switch result {
                case let .success(data):
                switch data {
                    case "Ok.":
                        Message.success(message: "添加成功", title: "磁力下载")
                        completion(true)
                    default:
                        Message.success(message: data, title: "磁力下载")
                        completion(false)
                    }
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
                print(error.localizedDescription)
                    completion(false)
            }
        }
    }
    
    func downloadFile(fileUrl: URL,fileName: String, completion: @escaping (Bool) -> Void) {
        NetworkAPi.downloadFile(fileUrl: fileUrl, fileName: fileName, model: self) {result in
            switch result {
                case let .success(data):
                switch data {
                    case "Ok.":
                        Message.success(message: "添加成功", title: "磁力下载")
                        completion(true)
                    default:
                        Message.error(message: data, title: "磁力下载")
                        completion(false)
                    }
                case let .failure(error):
                    Message.error(message: error.localizedDescription)
                    completion(false)
            }
        }
    }
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        return dict
      }
}
