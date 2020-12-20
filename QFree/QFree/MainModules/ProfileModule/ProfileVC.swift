//
//  ProfileVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit

protocol ProfileViewProtocol: class {
    func logOutLabelAction(_ sender: BaseButton)
    func changePassAction(_ sender: BaseButton)
    func changeEmailAction(_ sender: BaseButton)
    func showAlertMessage()
}

class ProfileVC: BaseViewController {
    public var presenter: ProfilePresenterProtocol?
    public var changeEmailVC: ChangeEmailVC?
    
    private var stackView: FormStackView!
    private var infoLabel: InfoLabel!
    private var changePassButton: BaseButton!
    private var changeEmailButton: BaseButton!
    private var logOutButton: BaseButton!
    
    private var stackViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupProfileForm()
    }
    
    private func setupTitle() {
        self.title = "Профиль"
    }
    
    private func setupProfileForm() {
        setupChangePassButton()
        setupChangeEmailButton()
        setupLogOutButton()
        setupStackView()
        setupInfoLabel()
    }
    
    private func setupChangePassButton() {
        changePassButton = BaseButton()
        changePassButton.setTitle("Сменить пароль", for: .normal)
        changePassButton.addTarget(self, action: #selector(changePassAction(_:)), for: .touchUpInside)
        
        changePassButton.translatesAutoresizingMaskIntoConstraints = false
        changePassButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
    }
    
    private func setupChangeEmailButton() {
        changeEmailButton = BaseButton()
        changeEmailButton.setTitle("Сменить почту", for: .normal)
        changeEmailButton.addTarget(self, action: #selector(changeEmailAction(_:)), for: .touchUpInside)
        
        changeEmailButton.translatesAutoresizingMaskIntoConstraints = false
        changeEmailButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
    }
    
    private func setupLogOutButton() {
        logOutButton = BaseButton()
        logOutButton.filled = false
        logOutButton.setTitle("Выйти", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutLabelAction(_:)), for: .touchUpInside)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
    }
    
    private func setupStackView() {
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            changePassButton,
            changeEmailButton,
            logOutButton
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
        infoLabel.showInfoLabel(text: (presenter?.getEmail())!)
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

extension ProfileVC: ProfileViewProtocol {
    @objc func logOutLabelAction(_ sender: BaseButton) {
        presenter?.logOut()
    }
    
    @objc func changePassAction(_ sender: BaseButton) {
        presenter?.changePassword()
    }
    
    func showAlertMessage() {
        let alert = UIAlertController(title: "Письмо для смены пароля было отправлено на вашу электронную почту", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in
            self.presenter?.logOut()
        }))
        self.present(alert, animated: true)
    }
    
    @objc func changeEmailAction(_ sender: BaseButton) {
        navigationController?.pushViewController(changeEmailVC!, animated: true)
    }
}
