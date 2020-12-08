//
//  ProfileModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation

class ProfileModuleBuilder{
    static func build() -> BaseViewController{
        let view = ProfileVC()
        let interactor = ProfileInteractor()
        let router = ProfileRouter(view: view)
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
