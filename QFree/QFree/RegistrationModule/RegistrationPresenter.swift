//
//  RegistrationPresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation

protocol RegistrationPresenterProtocol {
    
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
    
}
