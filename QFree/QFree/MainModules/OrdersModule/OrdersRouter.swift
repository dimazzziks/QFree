//
//  OrderRouter.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

import Foundation

protocol OrdersRouterProtocol { }

class OrdersRouter: OrdersRouterProtocol {
    var viewController: OrdersViewProtocol

    init(view: OrdersViewProtocol) {
        self.viewController = view
    }
}
