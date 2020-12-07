//
//  ProfileVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    var logOutButton: BaseButton!
    var changePassButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Профиль"
        self.view.backgroundColor = .white
        
        setupChanePassButton()
        setupLogOutButton()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.addSubview(changePassButton)
        self.view.addSubview(logOutButton)
    }
    
    func setupChanePassButton() {
        changePassButton = BaseButton(frame: CGRect(x: 12, y: Brandbook.viewHeight + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        changePassButton.setTitle("Сменить пароль", for: .normal)
        changePassButton.addTarget(self, action: #selector(changePassAction(_:)), for: .touchUpInside)
    }
    
    func setupLogOutButton() {
        logOutButton = BaseButton(frame: CGRect(x: 12, y: changePassButton.frame.origin.y + changePassButton.frame.height + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        logOutButton.setTitle("Выйти", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutLabelAction(_:)), for: .touchUpInside)
    }
}

extension ProfileVC {
    @objc func logOutLabelAction(_ sender: BaseButton) {
        do {
            try Auth.auth().signOut()
            Coordinator.presentVC(vc: EntranceModuleBuilder.build())
        } catch {
            print("Sigh out error")
        }
    }
    
    @objc func changePassAction(_ sender: BaseButton) {
        // TODO: - Change password
    }
}
