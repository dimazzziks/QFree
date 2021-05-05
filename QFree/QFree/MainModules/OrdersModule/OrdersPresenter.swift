//
//  OrderPresenter.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

protocol OrdersPresenterProtocol {
    func getOrders(completion: @escaping (Result<[OrderInfo], NetworkingError>) -> ())
}

class OrdersPresenter {
    weak var view: OrdersViewProtocol?
    var interactor: OrdersInteractorProtocol
    var router: OrdersRouterProtocol

    init(view: OrdersViewProtocol, interactor: OrdersInteractorProtocol, router: OrdersRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OrdersPresenter: OrdersPresenterProtocol {
    func getOrders(completion: @escaping (Result<[OrderInfo], NetworkingError>) -> ()) {
        interactor.getOrders { (result) in
            completion(result)
        }
    }


}
