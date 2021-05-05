//
//  OrderModuleBuilder.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

class OrderModuleBuilder {
    static func build(order: OrderInfo) -> BaseViewController {
        // FIXME: тут надо пробрасывать orderNumber и загружать нужный заказ
        let view = OrderViewController()
        let interactor = OrderInteractor(order: order)
        let router = OrderRouter(view: view)
        let presenter = OrderPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
