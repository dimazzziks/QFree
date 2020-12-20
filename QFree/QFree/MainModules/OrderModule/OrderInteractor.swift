//
//  OrderInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (OrderInfo?) -> ())
    func fetchBasket(completion: @escaping ([Product]?) -> ())
}

class OrderInteractor {
    var firebaseHandler = FirebaseHandler()
}

extension OrderInteractor: OrderInteractorProtocol {
    func fetchCurrentOrderInfo(completion: @escaping (OrderInfo?) -> ()) {
        firebaseHandler.getCurrentOrderInfo(email: "") { orderInfo in
            completion(orderInfo)
        }
    }
    
    func fetchBasket(completion: @escaping ([Product]?) -> ()) {
        firebaseHandler.getProductsInBasket(email: "") { products in
            completion(products)
        }
    }
}
