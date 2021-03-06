//
//  BasketModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

class BasketModuleBuilder {
    static func build() -> BaseViewController {
        let view = BasketViewController()
        let interactor = BasketInteractor()
        let router = BasketRouter(view: view)
        let presenter = BasketPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
