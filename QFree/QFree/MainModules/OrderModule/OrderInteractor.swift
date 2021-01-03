//
//  OrderInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (OrderInfo?) -> ())
    func fetchBasket(completion: @escaping (Result<[Product], NetworkingError>) -> ())
}

class OrderInteractor { }

extension OrderInteractor: OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (OrderInfo?) -> ()) {
        FirebaseHandler.shared.getCurrentOrderInfo(email: "") { orderInfo in
            completion(orderInfo)
        }
    }
    
    func fetchBasket(completion: @escaping (Result<[Product], NetworkingError>) -> ()) {
        FirebaseHandler.shared.getProductsInBasket(email: "") { result in
            completion(result)
        }
    }
}
