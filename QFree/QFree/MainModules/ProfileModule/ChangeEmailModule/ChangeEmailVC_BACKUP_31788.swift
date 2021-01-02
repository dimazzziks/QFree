//
//  ChangeEmailVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 08.12.2020.
//

import UIKit

protocol ChangeEmailProtocol{
    func changeEmailButtonAction(_ sender: BaseButton)
    func showAlertMessage()
}

class ChangeEmailVC: BaseViewController {
    var presenter: ProfilePresenter?
    
    private var stackView: FormStackView!
    private var oldEmailTextField: BaseTextField!
    private var newEmailTextField: BaseTextField!
    private var enterButton: BaseButton!
    private var infoLabel: UILabel!
    
    private var stackViewCenterYConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupEnterForm()
    }
    
    private func setupEnterForm() {
        
        newEmailTextField = BaseTextField()
<<<<<<< HEAD
        newEmailTextField.isSecureTextEntry = false
=======
>>>>>>> 72f11d0f582e338c63a70a1c621605c893baa6d5
        newEmailTextField.placeholder = "Новая почта"
        newEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        newEmailTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        enterButton = BaseButton()
        enterButton.addTarget(self, action: #selector(changeEmailButtonAction(_:)), for: .touchUpInside)
        enterButton.setTitle("Сменить почту", for: .normal)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            newEmailTextField,
            enterButton
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

extension ChangeEmailVC : ChangeEmailProtocol {
    
    @objc func changeEmailButtonAction(_ sender: BaseButton) {
        print("button pressed")
        presenter?.changeEmail(email: newEmailTextField.text!)
    }
    
    func showAlertMessage(){
        let alert = UIAlertController(title: "На вашу электронную почту было отправлено письмо для авторизации", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in 
            self.presenter?.logOut()
        }))
        self.present(alert, animated: true)
    }
    
}
