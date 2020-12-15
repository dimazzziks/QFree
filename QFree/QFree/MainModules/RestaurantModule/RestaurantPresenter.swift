//
//  RestaurantPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation

protocol RestaurantPresenterProtocol {
    
}

class RestaurantPresenter {
    weak var view: RestaurantViewProtocol?
    var interactor: RestaurantInteractorProtocol
    var router: RestaurantRouterProtocol
    
    init(view: RestaurantViewProtocol, interactor: RestaurantInteractorProtocol, router: RestaurantRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension RestaurantPresenter: RestaurantPresenterProtocol {
    
}
