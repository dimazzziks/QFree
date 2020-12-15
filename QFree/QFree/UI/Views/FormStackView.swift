//
//  FormStackView.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

class FormStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            super.addArrangedSubview(view)
        }
    }
}
