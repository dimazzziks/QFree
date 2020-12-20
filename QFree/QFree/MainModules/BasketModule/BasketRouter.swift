//
//  BasketRouter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol BasketRouterProtocol {
    var viewController: BasketViewProtocol { get set }
}

class BasketRouter: BasketRouterProtocol {
    var viewController: BasketViewProtocol
    
    init(view: BasketViewProtocol) {
        self.viewController = view
    }
}
