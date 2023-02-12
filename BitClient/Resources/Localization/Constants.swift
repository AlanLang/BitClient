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
}
