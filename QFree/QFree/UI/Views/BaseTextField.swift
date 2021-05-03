//
//  BaseTextField.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

class BaseTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = Brandbook.font(size: 18, weight: .regular)
        self.layer.cornerRadius = Brandbook.defaultCornerRadius
        layer.borderColor = Brandbook.defaultColor.cgColor
        tintColor = Brandbook.defaultColor
        setInitialAppearance()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setInitialAppearance() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension BaseTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        layer.borderColor = Brandbook.defaultColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setInitialAppearance()
    }
}
