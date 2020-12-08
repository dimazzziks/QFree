//
//  ChangeEmailVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 08.12.2020.
//

import UIKit

class ChangeEmailVC: UIViewController {
    
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
        oldEmailTextField = BaseTextField()
        oldEmailTextField.keyboardType = .emailAddress
        oldEmailTextField.placeholder = "Старая почта"
        oldEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        oldEmailTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        newEmailTextField = BaseTextField()
        newEmailTextField.placeholder = "Новая почта"
        newEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        newEmailTextField.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        enterButton = BaseButton()
        enterButton.addTarget(self, action: #selector(chaneEmailButtonAction(_:)), for: .touchUpInside)
        enterButton.setTitle("Сменить почту", for: .normal)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            oldEmailTextField,
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

extension ChangeEmailVC {
    
    @objc func chaneEmailButtonAction(_ sender: BaseButton) {
        // TODO: - Change Email Action
    }
    
}
