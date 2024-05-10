// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Maindata: Codable {
    let rid: Int
    let serverState: ServerState
    let torrents: [String: Torrent]

    enum CodingKeys: String, CodingKey {
        case rid
        case serverState = "server_state"
        case torrents
    }
}

// MARK: - Categories
struct Category: Codable {
    let savePath, name: String
}

typealias Categories = [String: Category]

// MARK: - ServerState
struct ServerState: Codable {
    // 节点数
    let dhtNodes: Int
    // 下载总量
    let dlInfoData: Int
    // 下载速度
    let dlInfoSpeed: Int
    // 磁盘剩余空间
    let freeSpaceOnDisk: Int
    // 平均分享率
    let globalRatio: String
    // 上传总量
    let upInfoData: Int
    // 上传速度
    let upInfoSpeed: Int
    // 是否开启用户限速
    let useAltSpeedLimits: Bool

    enum CodingKeys: String, CodingKey {
        case dhtNodes = "dht_nodes"
        case dlInfoData = "dl_info_data"
        case dlInfoSpeed = "dl_info_speed"
        case freeSpaceOnDisk = "free_space_on_disk"
        case globalRatio = "global_ratio"
        case upInfoData = "up_info_data"
        case upInfoSpeed = "up_info_speed"
        case useAltSpeedLimits = "use_alt_speed_limits"
    }
}

// MARK: - Torrent
struct Torrent: Codable {
    let name: String
    let size: Int
    let progress, ratio: Double
    let addedOn:Int
    let upspeed: Int
    let dlspeed: Int
    let timeActive: Int
    let state: String

    enum CodingKeys: String, CodingKey {
        case name
        case size
        case progress
        case ratio
        case addedOn = "added_on"
        case upspeed
        case dlspeed
        case timeActive = "time_active"
        case state
    }
}

enum TorrentState: String, Codable {
    case stalledUP = "stalledUP"
    case uploading = "uploading"
    case pausedUP = "pausedUP"
    case downloading = "downloading"
    case stalledDL = "stalledDL"
}

