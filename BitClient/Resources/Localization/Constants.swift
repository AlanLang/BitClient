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
}
