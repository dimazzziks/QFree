//
//  EmailConfirmationPresenter.swift
//  QFree
//
//  Created by User on 09.11.2020.
//

import FirebaseAuth

protocol EmailConfirmationPresenterProtocol {
    func confirmEmail()
    func resendEmailVerification()
    func deleteUser()
}

class EmailConfirmationPresenter {
    var view: EmailConfirmationViewProtocol
    var interactor: EmailConfirmationInteractorProtocol
    var router: EmailConfirmationRouterProtocol
    
    var isGoingForward = false
    
    init(view: EmailConfirmationViewProtocol, interactor: EmailConfirmationInteractorProtocol, router: EmailConfirmationRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension EmailConfirmationPresenter: EmailConfirmationPresenterProtocol {
    func confirmEmail() {
        let user = Auth.auth().currentUser!
        interactor.confirmEmail(completion: {
            if user.isEmailVerified {
                self.isGoingForward = true
                self.view.completeActivation()
            } else {
                self.view.failActivation()
            }
        })
    }
    
    func resendEmailVerification() {
        interactor.resendVerificationEmail()
    }
    
    func deleteUser() {
        if !isGoingForward {
            interactor.deleteUser() {}
        }
    }
}
