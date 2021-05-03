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
        if let font = UIFont(name: "\(defaultFontName)-\(weight.rawValue)", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
}

// MARK: - Colors

extension Brandbook {
    static var defaultColor: UIColor {
        UIColor(hex: "#6D80FF")
    }
    
    static var textColor: UIColor {
        UIColor(hex: "#4B4E57")
    }
}

// MARK: - Appearance

extension Brandbook {
    static var defaultCornerRadius: CGFloat { 8 }
    static var defaultButtonHeight: CGFloat { 48.0 }
}
