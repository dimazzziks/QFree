//
//  RegistrationPresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import Foundation

protocol RegistrationPresenterProtocol {
    func checkInfoAndCreateAccount(name: String?, email: String?, password: String?)
}

class RegistrationPresenter {
    weak var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorProtocol
    var router: RegistrationRouterProtocol
    
    init(view: RegistrationViewProtocol, interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {
    func checkInfoAndCreateAccount(name: String?, email: String?, password: String?) {
        let nameIsValid = interactor.nameIsValid(name)
        let emailIsValid = interactor.emailIsValid(email)
        let passwordIsValid = interactor.passwordIsValid(password)
        
        guard nameIsValid && emailIsValid && passwordIsValid else {
            if !nameIsValid {
                print("NAME IS NOT VALID")
            }
            if !emailIsValid {
                print("EMAIL IS NOT VALID")
            }
            if !passwordIsValid {
                print("PASSWORD IS NOT VALID")
            }
            return
        }
        interactor.createNewAccount(email!, password!) { (authError) in
            guard authError == nil else {
                // TODO: - handle error
                print("ERROR:", authError)
                return
            }
            // TODO: - go to main menu
            //print("SHOW MAIN MENU")
            self.router.pushEmailConfirmationController()
        }
    }
}
