//
//  Constants.swift
//  BitClient
//
//  Created by Vladimir Valter on 12.02.23.
//

import Foundation

/// Module name for localization
private let constants = "Constants"

struct Constants {
    struct LoginPage {
        static let serverAddress = "LoginPage.serverAdress".localized(moduleName: constants)
        static let login = "LoginPage.login".localized(moduleName: constants)
        static let password = "LoginPage.password".localized(moduleName: constants)
        static let buttonTitle = "LoginPage.buttonTitle".localized(moduleName: constants)
    }
    
    struct NavBar {
        
        struct Home {
            static let all = "NavBar.Home.all".localized(moduleName: constants)
            static let active = "NavBar.Home.active".localized(moduleName: constants)
            static let pause = "NavBar.Home.pause".localized(moduleName: constants)
        }
    }
    
    struct TabBar {
        static let list = "TabBar.list".localized(moduleName: constants)
        static let server = "TabBar.server".localized(moduleName: constants)
        static let about = "TabBar.about".localized(moduleName: constants)
    }
    
    struct Tips {
        static let noContent = "Tips.noContent".localized(moduleName: constants)
        static let noService = "Tips.noService".localized(moduleName: constants)
        static let offline = "Tips.offline".localized(moduleName: constants)
    }
    
    struct Utils {
        static let daysAgo = "Utils.daysAgo".localized(moduleName: constants)
        static let hoursAgo = "Utils.hoursAgo".localized(moduleName: constants)
        static let minutesAgo = "Utils.minutesAgo".localized(moduleName: constants)
        static let just = "Utils.just".localized(moduleName: constants)
        static let formatter = "Utils.dateFormatter".localized(moduleName: constants)
    }
    
    struct Server {

        static let freeDiskSpace = "Server.freeDiskSpace".localized(moduleName: constants)
        static let averageShareRate = "Server.averageShareRate".localized(moduleName: constants)
        static let downloadSpeed = "Server.downloadSpeed".localized(moduleName: constants)
        static let uploadSpeed = "Server.uploadSpeed".localized(moduleName: constants)
        static let alternateSpeedLimit = "Server.alternateSpeedLimit".localized(moduleName: constants)
        static let totalDownloads = "Server.totalDownloads".localized(moduleName: constants)
        static let totalUploads = "Server.totalUploads".localized(moduleName: constants)
        static let numberOfNodes = "Server.numberOfNodes".localized(moduleName: constants)
        static let signOut = "Server.signOut".localized(moduleName: constants)
    }
    
    struct About {
        static let web = "About.web".localized(moduleName: constants)
        static let license = "About.license".localized(moduleName: constants)
        static let changelog = "About.changelog".localized(moduleName: constants)
        static let settings = "About.settings".localized(moduleName: constants)
    }
    
    struct Add {
        static let magnet = "Add.magnet".localized(moduleName: constants)
        static let file = "Add.file".localized(moduleName: constants)
        static let magnetUrl = "Add.magnetUrl".localized(moduleName: constants)
        static let torrentFile = "Add.torrentFile".localized(moduleName: constants)
        static let selectTorrent = "Add.selectTorrent".localized(moduleName: constants)
        static let downloadSettings = "Add.downloadSettings".localized(moduleName: constants)
        static let savePath = "Add.savePath".localized(moduleName: constants)
        static let rename = "Add.rename".localized(moduleName: constants)
        static let pauseAfterAdding = "Add.pauseAfterAdding".localized(moduleName: constants)
        static let rootFolder = "Add.rootFolder".localized(moduleName: constants)
        static let sequentialDownload = "Add.sequentialDownload".localized(moduleName: constants)
        static let skipChecking = "Add.skipChecking".localized(moduleName: constants)
        static let selectCategory = "Add.selectCategory".localized(moduleName: constants)
        
        struct Warnings {
            static let emptyMessage = "Add.Warnings.emptyMessage".localized(moduleName: constants)
            static let emptyTitle = "Add.Warnings.emptyTitle".localized(moduleName: constants)
            static let fileMessage = "Add.Warnings.fileMessage".localized(moduleName: constants)
            static let fileTitle = "Add.Warnings.fileTitle".localized(moduleName: constants)
        }
        
        struct Alert {
            static let title = "Add.Alert.title".localized(moduleName: constants)
            static let message = "Add.Alert.message".localized(moduleName: constants)
            static let primaryButton = "Add.Alert.primaryButton".localized(moduleName: constants)
            static let secondaryButton = "Add.Alert.secondaryButton".localized(moduleName: constants)
        }
        
        struct NavBar {
            static let title = "Add.NavBar.title".localized(moduleName: constants)
        }
    }
}
