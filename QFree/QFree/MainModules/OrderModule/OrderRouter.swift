//
//  OrderRouter.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderRouterProtocol {
    
}

class OrderRouter: OrderRouterProtocol {
    var viewController: OrderViewProtocol
    
    init(view: OrderViewProtocol) {
        self.viewController = view
    }
}
