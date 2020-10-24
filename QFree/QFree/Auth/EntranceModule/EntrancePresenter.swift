//
//  EntrancePresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation

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
                view?.showEmailIsNotValid()
            }
            if !passwordIsValid {
                print("PASSWORD IS NOT VALID")
                view?.showPasswordIsNotValid()
            }
            return
        }
        
        print("OK!")
        interactor.signInAccount(email!, password!) { (authError) in
            guard authError == nil else {
                // TODO: - handle error
                print("ERROR:", authError)
                return
            }
            // TODO: - go to main menu
            print("SHOW MAIN MENU")
        }
    }
    
    func showRegistrationViewController() {
        self.router.pushCreateAccountViewController()
    }
}
