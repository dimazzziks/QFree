//
//  ProfileVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    var logOutLabel: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Профиль"
        self.view.backgroundColor = .white
        
        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.addSubview(logOutLabel)
    }
    
    func setupButton() {
        logOutLabel = BaseButton(frame: CGRect(x: 12, y: Brandbook.viewHeight + 12, width: self.view.frame.width - 24, height: Brandbook.defaultButtonHeight))
        logOutLabel.setTitle("Выйти", for: .normal)
        logOutLabel.addTarget(self, action: #selector(logOutLabelAction(_:)), for: .touchUpInside)
    }
}

extension ProfileVC {
    @objc func logOutLabelAction(_ sender: BaseButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sigh out error")
        }
    }
}
