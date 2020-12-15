//
//  RegistrationModuleBuilder.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import Foundation

class RegistrationModuleBuilder {
    static func build() -> BaseViewController {
        let view = RegistrationViewController()
        let interactor = RegistrationInteractor(authValidator: AuthValidator())
        let router = RegistrationRouter(view: view)
        let presenter = RegistrationPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
    
}
