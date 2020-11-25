//
//  Brandbook.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

final class Brandbook { }

// MARK: - Fonts

extension Brandbook {
    
    static let defaultFontName = "AvenirNext"
    
    enum Weight: String {
        case thin = "Thin"
        case regular = "Regular"
        case bold = "Bold"
        case medium = "Medium"
        case heavy = "Heavy"
    }
    
    static func font(size: CGFloat = 20, weight: Weight = .bold) -> UIFont {
        return UIFont(name: "\(defaultFontName)-\(weight.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
}

// MARK: - Colors

extension Brandbook {
    static var defaultColor: UIColor {
        return UIColor(hex: "#6D80FF")
    }
    
    static var textColor: UIColor {
        return UIColor(hex: "#4B4E57")
    }
}

// MARK: - Appearance

extension Brandbook {
    static var defaultCornerRadius: CGFloat {
        return 8
    }
}

extension Brandbook {
    static var defaultButtonHeight: CGFloat {
        return 48.0
    }
}
