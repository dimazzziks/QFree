//
//  TabBarModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 14.12.2020.
//

import UIKit

class TabBarModuleBuilder {
    static func build() -> UIViewController {
        let view = TabBarController()
        let interactor = TabBarInteractor()
        let router = TabBarRouter(view: view)
        let presenter = TabBarPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
