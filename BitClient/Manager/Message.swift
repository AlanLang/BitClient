//
//  Message.swift
//  BitClient
//
//  Created by Alan on 2021/11/7.
//

import Foundation
import SPIndicator
import UIKit

class Message {
    static func error(message: String, title: String = "错误"){
        SPIndicator.present(title: title, message: message, preset: .error)
    }
    
    static func warning(message: String, title: String = "提示"){
        let image = UIImage.init(systemName: "exclamationmark.triangle.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        SPIndicator.present(title: title, message: message, preset: .custom(image))
    }
    
    static func success(message: String, title: String = "成功"){
        SPIndicator.present(title: title, message: message, preset: .done)
    }
}
