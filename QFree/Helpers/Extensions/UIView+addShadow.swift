//
//  UIView+addShadow.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/7/20.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.cornerRadius = Brandbook.defaultCornerRadius
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
}
