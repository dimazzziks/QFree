//
//  OrdersInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

protocol OrdersInteractorProtocol {
    func getOrders(completion: @escaping (Result<[OrderPreview], NetworkingError>) -> ())
}

class OrdersInteractor { }

extension OrdersInteractor: OrdersInteractorProtocol {
    func getOrders(completion: @escaping (Result<[OrderPreview], NetworkingError>) -> ()) {
        FirebaseHandler.shared.getOrders { (result) in
            completion(result)
        }
    }
}
