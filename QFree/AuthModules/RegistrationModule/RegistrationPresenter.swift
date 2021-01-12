//
//  RegistrationPresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

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
                view?.showInfoLabel(text: "Введите имя")
                return
            }
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
        interactor.createNewAccount(email!, password!) { (authError) in
            guard authError == nil else {
                // TODO: - handle error
                #if DEBUG
                print(#function)
                print("ERROR:", authError ?? "authError")
                #endif
                return
            }
            self.router.pushEmailConfirmationController()
        }
    }
}
