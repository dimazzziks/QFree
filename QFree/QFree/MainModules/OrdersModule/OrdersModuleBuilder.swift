//
//  OrdersModuleBuilder.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

class OrdersModuleBuilder {
    static func build() -> BaseViewController {
        let view = OrdersViewController()
        let interactor = OrdersInteractor()
        let router = OrdersRouter(view: view)
        let presenter = OrdersPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}

