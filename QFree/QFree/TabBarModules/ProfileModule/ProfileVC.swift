//
//  ProfileVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit
import Firebase

protocol ProfileViewProtocol : class{
    func logOutLabelAction(_ sender: BaseButton)
    func changePassAction(_ sender: BaseButton)
    func changeEmailAction(_ sender: BaseButton)
}

class ProfileVC: BaseViewController {
    public var presenter: ProfilePresenterProtocol?

    var changePassButton: BaseButton!
    var changeEmailButton: BaseButton!
    var logOutButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Профиль"
        self.view.backgroundColor = .white
        
        setupChanePassButton()
        setupChangeEmailButton()
        setupLogOutButton()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.addSubview(changePassButton)
        self.view.addSubview(changeEmailButton)
        self.view.addSubview(logOutButton)
    }
    
    func setupChanePassButton() {
        changePassButton = BaseButton(frame: CGRect(x: 12, y: Brandbook.viewHeight + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        changePassButton.setTitle("Сменить пароль", for: .normal)
        changePassButton.addTarget(self, action: #selector(changePassAction(_:)), for: .touchUpInside)
    }
    
    func setupChangeEmailButton() {
        changeEmailButton = BaseButton(frame: CGRect(x: 12, y: changePassButton.frame.origin.y + changePassButton.frame.height + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        changeEmailButton.setTitle("Сменить почту", for: .normal)
        changeEmailButton.addTarget(self, action: #selector(changeEmailAction(_:)), for: .touchUpInside)
        
    }
    
    func setupLogOutButton() {
        logOutButton = BaseButton(frame: CGRect(x: 12, y: changeEmailButton.frame.origin.y + changeEmailButton.frame.height + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        logOutButton.filled = false
        logOutButton.setTitle("Выйти", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutLabelAction(_:)), for: .touchUpInside)
    }
}

extension ProfileVC : ProfileViewProtocol {
    @objc func logOutLabelAction(_ sender: BaseButton) {
        presenter?.logOut()
        /*do {
            try Auth.auth().signOut()
            Coordinator.rootVC(vc: BaseNavigationController(rootViewController: EntranceModuleBuilder.build()))
        } catch {
            print("Sigh out error")
        }*/
    }
    
    @objc func changePassAction(_ sender: BaseButton) {
        presenter?.changePassword {
            let alert = UIAlertController(title: "Письмо для смены пароля было отправлено на вашу электронную почту", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @objc func changeEmailAction(_ sender: BaseButton) {
        navigationController?.pushViewController(ChangeEmailVC(), animated: true)
    }
}
