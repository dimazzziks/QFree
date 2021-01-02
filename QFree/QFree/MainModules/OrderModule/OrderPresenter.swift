//
//  OrderPresenter.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderPresenterProtocol {
    func viewDidLoad()
}

class OrderPresenter {
    weak var view: OrderViewProtocol?
    var interactor: OrderInteractorProtocol
    var router: OrderRouterProtocol
    
    init(view: OrderViewProtocol, interactor: OrderInteractorProtocol, router: OrderRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OrderPresenter: OrderPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchCurrentOrderInfo { currentOrderInfo in
            guard let currentOrderInfo = currentOrderInfo else { return }
            self.view?.update(currentOrderInfo)
        }
        interactor.fetchBasket { products in
            guard let products = products else { return }
            self.view?.update(products)
        }
    }
}
