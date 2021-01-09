//
//  RegistrationRouter.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

protocol RegistrationRouterProtocol {
    var viewController: RegistrationViewProtocol { get set }
    func pushEmailConfirmationController()
}

class RegistrationRouter: RegistrationRouterProtocol {
    var viewController: RegistrationViewProtocol
    
    init(view: RegistrationViewProtocol) {
        self.viewController = view
    }
    
    func pushEmailConfirmationController() {
        viewController.pushEmailConfirmationController()
    }
}
