//
//  ChangeEmailVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 08.12.2020.
//

import UIKit

protocol ChangeEmailProtocol: class {
    func changeEmailButtonAction(_ sender: BaseButton)
    func showAlertMessage()
    func showInfoLabel(text: String)
}

class ChangeEmailVC: BaseViewController {
    var presenter: ProfilePresenter?
    
    private var stackView: FormStackView!
    private var infoLabel: InfoLabel!
    private var newEmailTextField: BaseTextField!
    private var changeButton: BaseButton!
    
    private var stackViewCenterYConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupChangeEmailForm()
    }
    
    private func setupTitle() {
        title = "Смена почты"
    }
    
    private func setupChangeEmailForm() {
        setupNewEmailTextField()
        setupChangeButton()
        setupStackView()
        setupInfoLabel()
    }
    
    private func setupNewEmailTextField() {
        newEmailTextField = BaseTextField()
        newEmailTextField.placeholder = "Новая почта"
        newEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        newEmailTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
    }
    
    private func setupChangeButton() {
        changeButton = BaseButton()
        changeButton.addTarget(self, action: #selector(changeEmailButtonAction(_:)), for: .touchUpInside)
        changeButton.setTitle("Сменить почту", for: .normal)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
    }
    
    private func setupStackView() {
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            newEmailTextField,
            changeButton
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
    
    private func setupInfoLabel() {
        infoLabel = InfoLabel()
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

extension ChangeEmailVC: ChangeEmailProtocol {
    @objc func changeEmailButtonAction(_ sender: BaseButton) {
        presenter?.changeEmail(email: newEmailTextField.text!)
    }
    
    func showAlertMessage() {
        let alert = UIAlertController(title: "На вашу электронную почту было отправлено письмо для авторизации", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in 
            self.presenter?.logOut()
        }))
        self.present(alert, animated: true)
    }
    
    func showInfoLabel(text: String) {
        infoLabel.showInfoLabel(text: text)
    }
}
