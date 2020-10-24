//
//  UIView+cornerRadius.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
