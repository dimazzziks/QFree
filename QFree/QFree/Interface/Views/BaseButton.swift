//
//  BaseButton.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

class BaseButton: UIButton {
    
    public var filled: Bool = false {
        didSet {
            if filled {
                backgroundColor = Brandbook.defaultColor
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .white
                setTitleColor(Brandbook.defaultColor, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        backgroundColor = Brandbook.defaultColor
        cornerRadius = Brandbook.defaultCornerRadius
        titleLabel?.font = Brandbook.font()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
