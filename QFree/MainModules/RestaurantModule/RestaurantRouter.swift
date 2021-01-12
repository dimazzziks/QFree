//
//  RestaurantRouter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol RestaurantRouterProtocol {
    var viewController: RestaurantViewProtocol { get set }
}

class RestaurantRouter: RestaurantRouterProtocol {
    var viewController: RestaurantViewProtocol
    
    init(view: RestaurantViewProtocol) {
        self.viewController = view
    }
}
