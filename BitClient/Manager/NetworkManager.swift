//
//  NetworkManager.swift
//  BitClient
//
//  Created by Alan on 2021/11/6.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){
        
    }
    
    var commonHeaders: HTTPHeaders {
        []
    }
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(path, parameters: parameters, headers: commonHeaders, requestModifier: {$0.timeoutInterval = 15 })
            .responseData{response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(self.handleError(error))
                }
            }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(path, method: .post, parameters: parameters, encoding: URLEncoding.default , headers: commonHeaders, requestModifier: {$0.timeoutInterval = 15 })
            .responseData(emptyResponseCodes: [200, 204, 205]){response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(self.handleError(error))
                }
            }
    }
    
    func sendFile(path: String, fileURL: URL, fileName: String, parameters:Dictionary<String, String>, completion: @escaping NetworkRequestCompletion) {
        AF.upload(multipartFormData: {multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
            do {
                let fileData = try? Data(contentsOf: fileURL)
                multiPart.append(fileData!, withName: "file", fileName: fileName, mimeType: "application/octet-stream")
            }
            
        }, to: path, method: .post ).responseData(emptyResponseCodes: [200, 204, 205]){response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(self.handleError(error))
            }
        }
    }
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
            if let underlyingError = error.underlyingError {
                let nserror = underlyingError as NSError
                let code = nserror.code
                if  code == NSURLErrorNotConnectedToInternet ||
                    code == NSURLErrorTimedOut ||
                    code == NSURLErrorInternationalRoamingOff ||
                    code == NSURLErrorDataNotAllowed ||
                    code == NSURLErrorCannotFindHost ||
                    code == NSURLErrorCannotConnectToHost ||
                    code == NSURLErrorNetworkConnectionLost {
                    var userInfo = nserror.userInfo
                    userInfo[NSLocalizedDescriptionKey] = "网络连接有问题喔～"
                    let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                    return .failure(currentError)
                }
            }
            return .failure(error)
        }
}
