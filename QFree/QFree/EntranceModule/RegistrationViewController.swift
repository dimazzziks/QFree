//
//  RegistrationViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

protocol EntranceViewProtocol: class {
    
}

class EntranceViewController: BaseViewController {
    public var presenter: EntrancePresenterProtocol?
    
    private var stackView: FormStackView!
    private var emailTextfield: UITextField!
    private var passwordTextfield: UITextField!
    private var enterButton: BaseButton!
    private var createAccountButton: BaseButton!
    
    private var stackViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupEnterForm()
    }
    
    private func setupTitle() {
        title = "Вход"
    }
    
    private func setupEnterForm() {
        emailTextfield = BaseTextField()
        emailTextfield.keyboardType = .emailAddress
        emailTextfield.placeholder = "Почта"
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        passwordTextfield = BaseTextField()
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.placeholder = "Пароль"
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        enterButton = BaseButton()
        enterButton.setTitle("Войти", for: .normal)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        createAccountButton = BaseButton()
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        createAccountButton.filled = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            emailTextfield,
            passwordTextfield,
            enterButton,
            createAccountButton
        )
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewCenterYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewCenterYConstraint,
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    override func keyboardWillAppear() {
        stackViewCenterYConstraint.isActive = false
        self.stackViewCenterYConstraint = self.stackView.centerYAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor, constant: -75)
        updateStackViewCenterYConstraint()
    }
    
    override func keyboardWillDisappear() {
        stackViewCenterYConstraint.isActive = false
        self.stackViewCenterYConstraint = self.stackView.centerYAnchor.constraint(greaterThanOrEqualTo: self.view.centerYAnchor)
        updateStackViewCenterYConstraint()
        
    }
    
    private func updateStackViewCenterYConstraint() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.stackViewCenterYConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
}


extension EntranceViewController: EntranceViewProtocol {
    
}
