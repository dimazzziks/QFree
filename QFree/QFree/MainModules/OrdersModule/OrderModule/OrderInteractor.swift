//
//  OrderInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (Result<OrderInfo, NetworkingError>) -> ())
    func fetchBasket(completion: @escaping (Result<[Product], NetworkingError>) -> ())
}

class OrderInteractor { }

extension OrderInteractor: OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (Result<OrderInfo, NetworkingError>) -> ()) {
        FirebaseHandler.shared.getCurrentOrderInfo { (result) in
            completion(result)
        }
    }
    
    func fetchBasket(completion: @escaping (Result<[Product], NetworkingError>) -> ()) {
        FirebaseHandler.shared.getProductsInBasket(email: "") { result in
            completion(result)
        }
    }
}
