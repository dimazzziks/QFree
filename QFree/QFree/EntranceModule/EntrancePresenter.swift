//
//  EntrancePresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation

protocol EntrancePresenterProtocol {
    func checkEmailAndPasswordAndEnter(_ email: String?, _ password: String?)
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
    func checkEmailAndPasswordAndEnter(_ email: String?, _ password: String?) {
        let emailIsValid = interactor.emailIsValid(email)
        let passwordIsValid = interactor.passwordIsValid(password)
        
        guard emailIsValid && passwordIsValid else {
            if !emailIsValid {
                view?.showEmailIsNotValid()
            }
            if !passwordIsValid {
                view?.showPasswordIsNotValid()
            }
            return
        }
        
        print("OK!")
        interactor.signInAccount(email!, password!) { (error) in
            guard error == nil else {
                // TODO: - go to main menu
                return
            }
            // TODO: - handle error
        }
    }
}
