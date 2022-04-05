//
//  NetworkAPI.swift
//  BitClient
//
//  Created by Alan on 2021/11/6.
//

import Foundation

class NetworkAPi {
    static let shared = NetworkAPi()
    
    // 系统登录
    static func login(bitService: BitService, completion: @escaping (Result<String, Error>) -> Void){
        NetworkManager.shared.requestPost(path: Self.getFormatUrl(bitService.url) + "/api/v2/auth/login", parameters: ["username": bitService.username, "password": bitService.password]) {result in
            switch result {
                case let .success(data):
                    let utf8Text = String(data: data, encoding: .utf8)
                    if(utf8Text == nil) {
                        let error = NSError(domain: "NetworkApiError", code: 0, userInfo: ["NSLocalizedDescriptionKey": "数据解析出错"])
                        completion(.failure(error))
                    }else{
                        completion(.success(utf8Text ?? ""))
                    }
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    // 获取数据
    static func getMainData(completion: @escaping (Result<Maindata, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: self.basicUrl + "/api/v2/sync/maindata", parameters: ["rid": "0", "kvoyjzay":""]) {result in
            switch result {
            case let .success(data):
                let result:Result<Maindata, Error> = self.parseData(data)
                completion(result)
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
    // 获取偏好设置
    static func preferences(completion: @escaping (Result<PreferenceData, Error>) -> Void){
        NetworkManager.shared.requestGet(path: self.basicUrl + "/api/v2/app/preferences?kvs01ybv", parameters: nil){result in
            switch result {
            case let .success(data):
                let result:Result<PreferenceData, Error> = self.parseData(data)
                completion(result)
            case let .failure(error): completion(.failure(error))
            }
            
        }
    }
    // 添加下载
    static func download(model: AddTorrentLinkFormModel, completion: @escaping (Result<String, Error>) -> Void){
        let parameters: [String: Any] = [
            "urls": model.urls,
            "savepath": model.savepath,
            "paused": String(model.paused),
            "root_folder": String(model.root_folder),
            "sequentialDownload": String(model.sequentialDownload),
            "skip_checking": String(model.skip_checking),
            "rename": model.rename
        ]
        
        NetworkManager.shared.requestPost(path: self.basicUrl + "/api/v2/torrents/add", parameters: parameters) { result in
            switch result {
                case let .success(data):
                    let utf8Text = String(data: data, encoding: .utf8)
                    if(utf8Text == nil) {
                        let error = NSError(domain: "NetworkApiError", code: 0, userInfo: ["NSLocalizedDescriptionKey": "数据解析出错"])
                        completion(.failure(error))
                    }else{
                        completion(.success(utf8Text ?? ""))
                    }
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    static func downloadFile(fileUrl: URL, fileName: String, model: AddTorrentLinkFormModel, completion: @escaping (Result<String, Error>) -> Void){
        let parameters: [String: String] = [
            "savepath": model.savepath,
            "paused": String(model.paused),
            "root_folder": String(model.root_folder),
            "sequentialDownload": String(model.sequentialDownload),
            "skip_checking": String(model.skip_checking),
            "rename": model.rename
        ]
        
        NetworkManager.shared.sendFile(path: self.basicUrl + "/api/v2/torrents/add", fileURL: fileUrl, fileName: fileName, parameters: parameters) {result in
            switch result {
                case let .success(data):
                    let utf8Text = String(data: data, encoding: .utf8)
                    if(utf8Text == nil) {
                        let error = NSError(domain: "NetworkApiError", code: 0, userInfo: ["NSLocalizedDescriptionKey": "数据解析出错"])
                        completion(.failure(error))
                    }else{
                        completion(.success(utf8Text ?? ""))
                    }
                case let .failure(error):
                    completion(.failure(error))
            }
            
        }
    }
    
    // 暂停
    static func pause(id: String, completion: @escaping (Result<Bool, Error>) -> Void){
        NetworkManager.shared.requestPost(path: self.basicUrl + "/api/v2/torrents/pause", parameters: ["hashes": id]) { result in
            switch result {
                case .success(_):
                    completion(.success(true))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    // 继续
    static func resume(id: String, completion: @escaping (Result<Bool, Error>) -> Void){
        NetworkManager.shared.requestPost(path: self.basicUrl + "/api/v2/torrents/resume", parameters: ["hashes": id]) { result in
            switch result {
                case .success(_):
                    completion(.success(true))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    // 删除
    static func delete(id: String,deleteFiles: Bool, completion: @escaping (Result<Bool, Error>) -> Void){
        NetworkManager.shared.requestPost(path: self.basicUrl + "/api/v2/torrents/delete", parameters: ["hashes": id, "deleteFiles": String(deleteFiles)]) { result in
            switch result {
                case .success(_):
                    completion(.success(true))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }

    // 限速/取消限速
    static func toggleSpeedLimitsMode(completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: self.basicUrl + "/api/v2/transfer/toggleSpeedLimitsMode", parameters: nil) { result in
            switch result {
                case .success(_):
                    completion(.success(true))
                case let .failure(error):
                    completion(.failure(error))
            }
        }
    }
    
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    private static func getFormatUrl(_ url: String) -> String{
        var url = url
        if(url.hasSuffix("/")) {
            url.removeLast()
        }
        return url
    }
    
    private static var basicUrl: String {
        get {
            return self.getFormatUrl(BitService().url)
        }
    }
}
