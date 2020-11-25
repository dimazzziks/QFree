//
//  EmailConfirmationModuleBuilder.swift
//  QFree
//
//  Created by User on 09.11.2020.
//

import UIKit

class EmailConfirmationModuleBuilder{
    static func build() -> BaseViewController{
        let view = EmailConfirmationViewController()
        let interactor = EmailConfirmationInteractor()
        let router = EmailConfirmationRouter(view: view)
        let presenter = EmailConfirmationPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
