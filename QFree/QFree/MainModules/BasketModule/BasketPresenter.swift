//
//  BasketPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation

protocol BasketPresenterProtocol {
    
}

class BasketPresenter {
    weak var view: BasketViewProtocol?
    var interactor: BasketInteractorProtocol
    var router: BasketRouterProtocol
    
    init(view: BasketViewProtocol, interactor: BasketInteractorProtocol, router: BasketRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterProtocol {
    
}
