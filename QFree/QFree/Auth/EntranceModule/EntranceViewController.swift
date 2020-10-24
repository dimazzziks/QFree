//
//  EntranceViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

protocol EntranceViewProtocol: class {
    func showPasswordIsNotValid()
    func showEmailIsNotValid()
}

class EntranceViewController: BaseViewController {
    public var presenter: EntrancePresenterProtocol?
    
    private var stackView: FormStackView!
    private var emailTextfield: BaseTextField!
    private var passwordTextfield: BaseTextField!
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
        
        let elementHeight: CGFloat = 48
        
        emailTextfield = BaseTextField()
        emailTextfield.keyboardType = .emailAddress
        emailTextfield.placeholder = "Почта"
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextfield.heightAnchor.constraint(equalToConstant: elementHeight)
        ])
        
        passwordTextfield = BaseTextField()
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.placeholder = "Пароль"
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        
        enterButton = BaseButton()
        enterButton.addTarget(self, action: #selector(enterButtonAction(_:)), for: .touchUpInside)
        enterButton.setTitle("Войти", for: .normal)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        
        createAccountButton = BaseButton()
        createAccountButton.addTarget(self, action: #selector(createAccountButtonAction(_:)), for: .touchUpInside)
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        createAccountButton.filled = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        
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
}

extension EntranceViewController{
    @objc func enterButtonAction(_ sender: BaseButton) {
        print("Enter")
        presenter?.checkEmailAndPasswordAndEnter(emailTextfield.text, passwordTextfield.text)
    }
    
    @objc func createAccountButtonAction(_ sender: BaseButton) {
        print("Create account")
    }
}

extension EntranceViewController {
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
    func showEmailIsNotValid() {
        print(#function)
    }
    
    func showPasswordIsNotValid() {
        print(#function)
    }
}
