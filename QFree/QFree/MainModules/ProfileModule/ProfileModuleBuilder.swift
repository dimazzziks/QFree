//
//  ProfileModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation

class ProfileModuleBuilder{
    static func build() -> BaseViewController {
        let view = ProfileVC()
        let changeEmailVC = ChangeEmailVC()
        let interactor = ProfileInteractor()
        let router = ProfileRouter(view: view, changeEmailView: changeEmailVC)
        let presenter = ProfilePresenter(view: view, changeEmailview: changeEmailVC, interactor: interactor, router: router)
        view.presenter = presenter
        changeEmailVC.presenter = presenter
        view.changeEmailVC = changeEmailVC
        return view
    }
}
