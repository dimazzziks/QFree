//
//  OrdersInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

protocol OrdersInteractorProtocol {
    func getOrders(completion: @escaping (Result<[OrderInfo], NetworkingError>) -> ())
}

class OrdersInteractor { }
//FIXME:
extension OrdersInteractor: OrdersInteractorProtocol {
    func getOrders(completion: @escaping (Result<[OrderInfo], NetworkingError>) -> ()) {
//        FirebaseHandler.shared.getOrders {(result) in
//            completion(result)
//        }
    }
}
