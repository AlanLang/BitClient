//
//  PreferenceData.swift
//  BitClient
//
//  Created by alan on 2021/11/9.
//

import Foundation

// MARK: - PreferenceData
struct PreferenceData: Codable {
    let savePath: String
    
    enum CodingKeys: String, CodingKey {
        case savePath = "save_path"
    }
}
