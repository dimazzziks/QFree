//
//  RegistrationViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

protocol RegistrationViewProtocol: class {
    
}

class RegistrationViewController: BaseViewController, RegistrationViewProtocol {
    public var presenter: RegistrationPresenterProtocol?
    
    private var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
    }
    
    private func setupTitle() {
        titleLabel = UILabel()
        titleLabel.text = "Это экран регистрации"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
