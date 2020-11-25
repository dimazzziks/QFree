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
    
    var presenter : EmailConfirmationPresenterProtocol?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.presenter?.deleteUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfirmationForm()
        presenter?.resendEmailVerification()
    }
    
    private func addConstraints(item : UIView, centerX : Double, centerY : Double, width : Double, height : Double){
        let horizontalConstraint = NSLayoutConstraint(item: item, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: CGFloat(centerX))
        let verticalConstraint = NSLayoutConstraint(item: item, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: CGFloat(centerY))
        let widthConstraint = NSLayoutConstraint(item: item, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(width))
        let heightConstraint = NSLayoutConstraint(item: item, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(height))
        self.view.addSubview(item)
        self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    private func setupConfirmationForm(){
        
        let screenSize = UIScreen.main.bounds
        
        infoLabel = UILabel()
        infoLabel.text = "Письмо с подтверждением было выслано на вашу электронную почту. Пожалуйста, подтвердите свою почту, перейдя по ссылке из письма."
        infoLabel.numberOfLines = 3
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(item: infoLabel, centerX: 5, centerY: Double(screenSize.size.height)/3, width: Double(screenSize.size.width) - 10, height: 100)
        
        resendLinkButton = BaseButton()
        resendLinkButton.setTitle("Отправить письмо заново", for: .normal)
        resendLinkButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(item: resendLinkButton, centerX: 5, centerY: Double(screenSize.size.height)-200, width: Double(screenSize.size.width) - 10, height: 30)
        resendLinkButton.addTarget(self, action: #selector(resendVerificationEmail(_:)), for: .touchUpInside)
        
        confirmEmailButton = BaseButton()
        confirmEmailButton.setTitle("Подтвердить почту", for: .normal)
        confirmEmailButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(item: confirmEmailButton, centerX: 5, centerY: Double(screenSize.size.height)-130, width: Double(screenSize.size.width) - 10, height: 30)
        confirmEmailButton.addTarget(self, action: #selector(confirmEmail(_:)), for: .touchUpInside)
        
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(item: loadingIndicator, centerX: Double(screenSize.midX) - 50, centerY: Double(screenSize.midY) - 50, width: 100, height: 100)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        
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