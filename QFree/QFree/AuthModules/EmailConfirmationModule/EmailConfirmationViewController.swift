//
//  EmailConfirmationViewController.swift
//  QFree
//
//  Created by User on 09.11.2020.
//

import UIKit
import FirebaseAuth

protocol EmailConfirmationViewProtocol : class {
    func confirmEmail(_ sender : BaseButton)
    func resendVerificationEmail(_ sender : BaseButton)
    func completeActivation()
    func failActivation()
}

class EmailConfirmationViewController : BaseViewController{
    private var infoLabel : UILabel!
    private var resendLinkButton : BaseButton!
    private var confirmEmailButton : BaseButton!
    private var loadingIndicator : UIActivityIndicatorView!
    
    private var stopAnimating = false
    
    var presenter : EmailConfirmationPresenterProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if(stopAnimating){
            self.presenter?.deleteUser()
        }
        else{
            stopAnimating = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.resendEmailVerification()
        let queue = DispatchQueue.global()
        queue.async {
            while(!self.stopAnimating && !Auth.auth().currentUser!.isEmailVerified){
                Auth.auth().currentUser?.reload(completion: nil)
                sleep(1)
            }
            if(!self.stopAnimating)
            {
                DispatchQueue.main.async {
                    Coordinator.rootVC(vc: TabBarController())
                }
            }
            else{
                self.presenter?.deleteUser()
            }
            
        }
    }
    
    private func setupUI() {
        
        infoLabel = UILabel()
        infoLabel.text = "Письмо с подтверждением было выслано на вашу электронную почту. \nПожалуйста, подтвердите свою почту, перейдя по ссылке из письма."
        infoLabel.font = Brandbook.font(size: 16, weight: .bold)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        resendLinkButton = BaseButton()
        resendLinkButton.setTitle("Отправить письмо заново", for: .normal)
        resendLinkButton.addTarget(self, action: #selector(resendVerificationEmail(_:)), for: .touchUpInside)
        resendLinkButton.translatesAutoresizingMaskIntoConstraints = false
        resendLinkButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        confirmEmailButton = BaseButton()
        confirmEmailButton.setTitle("Подтвердить почту", for: .normal)
        confirmEmailButton.addTarget(self, action: #selector(confirmEmail(_:)), for: .touchUpInside)
        confirmEmailButton.translatesAutoresizingMaskIntoConstraints = false
        confirmEmailButton.heightAnchor.constraint(equalToConstant: Brandbook.defaultButtonHeight).isActive = true
        
        let stackView = FormStackView()
        stackView.spacing = 16
        stackView.addArrangedSubviews(
            resendLinkButton,
            confirmEmailButton
        )
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
extension EmailConfirmationViewController : EmailConfirmationViewProtocol{
    
    @objc func confirmEmail(_ sender : BaseButton){
        presenter?.confirmEmail()
    }
    
    @objc func resendVerificationEmail(_ sender : BaseButton){
        presenter?.resendEmailVerification()
    }
    
    func completeActivation(){
        loadingIndicator.stopAnimating()
    }
    
    func failActivation(){
        let alert = UIAlertController(title: "Почта не была активирована", message: "Попробуйте еще раз позже", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
