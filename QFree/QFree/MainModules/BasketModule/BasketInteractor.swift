//
//  BasketInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol BasketInteractorProtocol {
    func makeOrder(number: Int, basket: [ProductInfo : Int], restaurants: [Restaurant], completion: @escaping (NetworkingError?) -> ())
}

class BasketInteractor { }

extension BasketInteractor: BasketInteractorProtocol {
    func makeOrder(number: Int, basket: [ProductInfo: Int], restaurants: [Restaurant], completion: @escaping (NetworkingError?) -> ()) {
        FirebaseHandler.shared.makeOrder(number: number, basket: basket, restaurants: restaurants) { (error) in
            completion(error)
        }
    }
}
