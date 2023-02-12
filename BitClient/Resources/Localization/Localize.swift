//
//  Localize.swift
//  BitClient
//
//  Created by Vladimir Valter on 12.02.23.
//

import UIKit
fileprivate final class Localization { }

public let bundle = Bundle(for: Localization.self)

/// Локализует по файлу Localizable из конкретного модуля, если moduleName не прокидывать, локализует из общего файла Localizable.strings
/// - Parameters:
///   - key: ключ
///   - bundle: бандл
///   - moduleName: имя модуля, в папке с модулем обязательно должен лежать файл .strings с именованием "{ИМЯ_МОДУЛЯ}_Localizable.strings"
/// - Returns: локализованная строка
public func LS(_ key: String,
               bundle: Bundle = bundle,
               moduleName: String? = nil,
               parameter: LocalizedParameter? = nil) -> String {
    let tableName: String
    if let moduleName = moduleName {
        tableName = "\(moduleName)_Localizable"
    } else {
        tableName = "Localizable"
    }
    if let parameter = parameter {
        switch parameter {
        case .string(let str):
            return String.localizedStringWithFormat(NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: ""), str)
        case .strings(let strings):
            return String(format: NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: ""),
                          arguments: strings)
        case .int(let int):
            return String.localizedStringWithFormat(NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: ""), int)
        }
    } else {
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: "")
    }
}

public func LS(_ key: String,
               bundle: Bundle = bundle,
               moduleName: String? = nil,
               parameters: CVarArg...) -> String {
    let tableName: String
    if let moduleName = moduleName {
        tableName = "\(moduleName)_Localizable"
    } else {
        tableName = "Localizable"
    }
    return String.localizedStringWithFormat(NSLocalizedString(key, tableName: tableName, bundle: bundle, value: "", comment: ""), parameters)
}

public enum LocalizedParameter {
    case string(_ string: String)
    case strings(_ strings: [String])
    case int(_ int: Int)

    var substitute: String {
        switch self {
        case .string:
            return "%@"
        case .strings:
            return "%@"
        case .int:
            return "%d"
        }
    }
}

public enum LocalizedNumbers: String {
    case MonthsCount
    case HoursCount
    case DaysCount

    public func localized(moduleName: String? = nil, count: Int? = nil) -> String {
        guard let count = count else { return LS(self.rawValue, moduleName: moduleName) }
        let formatString = LS(self.rawValue, moduleName: moduleName)
        let resultString: String
        switch self {
        case .MonthsCount:
            resultString = String.localizedStringWithFormat(formatString, count)
        default:
            resultString = String.localizedStringWithFormat(formatString, Double(count))
        }
        return resultString
    }
}

public extension String {

    var localized: String {
        localized()
    }
    
    ///  Localize
    /// - Parameter moduleName: default = Constants
    /// - Returns: LocalizedString
    func localized(moduleName: String = "Constants") -> String {
        return LS(self, moduleName: moduleName)
    }

    func localized(moduleName: String? = nil, parameter: LocalizedParameter) -> String {
        return LS(self, moduleName: moduleName, parameter: parameter)
    }

    func localized(moduleName: String? = nil, count: Double? = nil) -> String {
        guard let count = count else { return LS(self, moduleName: moduleName) }
        let formatString = LS(self, moduleName: moduleName)
        let resultString = String.localizedStringWithFormat(formatString, count)
        return resultString
    }

    func localized(moduleName: String? = nil, count: Int? = nil) -> String {
        guard let count = count else { return LS(self, moduleName: moduleName) }
        let formatString = LS(self, moduleName: moduleName)
        let resultString = String.localizedStringWithFormat(formatString, Double(count))
        return resultString
    }
}

@IBDesignable
extension UILabel {
    
    @IBInspectable var localizedString: String? {
        get {
            text ?? ""
        }
        set {
            text = newValue?.localized(moduleName: "Storyboards")
        }
    }
}

