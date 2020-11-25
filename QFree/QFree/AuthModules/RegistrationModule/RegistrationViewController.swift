//
//  RegistrationViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

protocol RegistrationViewProtocol: class {
    func pushEmailConfirmationController()
    func showInfoLabel(text: String)
}

class RegistrationViewController: BaseViewController {
    public var presenter: RegistrationPresenterProtocol?
    
    private var infoLabel: UILabel!
    private var stackView: FormStackView!
    private var nameTextField: BaseTextField!
    private var emailTextField: BaseTextField!
    private var passwordTextField: BaseTextField!
    private var createAccountButton: BaseButton!
    
    private var stackViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupEnterForm()
    }
    
    private func setupTitle() {
        title = "Новый аккаунт"
    }
    
    private func setupEnterForm() {
        nameTextField = BaseTextField()
        nameTextField.placeholder = "Имя"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        emailTextField = BaseTextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = "Почта"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        passwordTextField = BaseTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Пароль"
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        createAccountButton = BaseButton()
        createAccountButton.addTarget(self, action: #selector(createAccountButtonAction(_:)), for: .touchUpInside)
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        createAccountButton.filled = true
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            nameTextField,
            emailTextField,
            passwordTextField,
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
        
        infoLabel = UILabel()
        infoLabel.font = Brandbook.font(size: 16, weight: .bold)
        infoLabel.textColor = .red
        infoLabel.alpha = 0.0
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

extension RegistrationViewController {
    @objc func createAccountButtonAction(_ sender: BaseButton) {
        presenter?.checkInfoAndCreateAccount(
            name: nameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text
        )
    }
}

extension RegistrationViewController {
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

extension RegistrationViewController: RegistrationViewProtocol {
    func pushEmailConfirmationController(){
        navigationController?.pushViewController(EmailConfirmationModuleBuilder.build(), animated: true)
    }
    
    func showInfoLabel(text: String) {
        infoLabel.text = text
        
        let animationDuration: TimeInterval = 0.3
        let delayDuration: TimeInterval = 3
        
        UIView.animate(withDuration: animationDuration) {
            self.infoLabel.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: animationDuration, delay: delayDuration, animations: {
                self.infoLabel.alpha = 0.0
            }, completion: nil)
        }
    }
}
