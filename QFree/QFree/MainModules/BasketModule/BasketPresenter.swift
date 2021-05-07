//
//  BasketPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol BasketPresenterProtocol {
    func makeOrder(number: Int, basket: [ProductInfo : Int], restaurants: [Restaurant],  completion: @escaping (NetworkingError?) -> ())
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
    func makeOrder(number: Int, basket: [ProductInfo : Int], restaurants: [Restaurant], completion: @escaping (NetworkingError?) -> ()) {
        interactor.makeOrder(number: number, basket: basket, restaurants: restaurants ) { error in
            completion(error)
        }
    }
}
