//
//  OrderModuleBuilder.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

class OrderModuleBuilder {
    static func build() -> BaseViewController {
        let view = OrderViewController()
        let interactor = OrderInteractor()
        let router = OrderRouter(view: view)
        let presenter = OrderPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
