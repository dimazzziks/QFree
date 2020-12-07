//
//  EntrancePresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation
import UIKit

protocol EntrancePresenterProtocol {
    func checkInfoAndEnter(_ email: String?, _ password: String?)
    func showRegistrationViewController()
}

class EntrancePresenter {
    weak var view: EntranceViewProtocol?
    var interactor: EntranceInteractorProtocol
    var router: EntranceRouterProtocol
    
    init(view: EntranceViewProtocol, interactor: EntranceInteractorProtocol, router: EntranceRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension EntrancePresenter: EntrancePresenterProtocol {
    func checkInfoAndEnter(_ email: String?, _ password: String?) {
        let emailIsValid = interactor.emailIsValid(email)
        let passwordIsValid = interactor.passwordIsValid(password)
        
        guard emailIsValid && passwordIsValid else {
            if !emailIsValid {
                print("EMAIL IS NOT VALID")
                view?.showInfoLabel(text: "Некорректная почта")
                return
            }
            if !passwordIsValid {
                print("PASSWORD IS NOT VALID")
                view?.showInfoLabel(text: "Некорректный пароль")
                return
            }
            return
        }
        
        print("OK!")
        interactor.signInAccount(email!, password!) { (authError) in
            guard authError == nil else {
                // TODO: - handle error
                print("ERROR:", authError ?? "authError")
                self.view?.showInfoLabel(text: "Некооректная информация")
                return
            }
            
            Coordinator.presentVC(vc: TabBarController())
        }
    }
    
    func showRegistrationViewController() {
        self.router.pushCreateAccountViewController()
    }
}
