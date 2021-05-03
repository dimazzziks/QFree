//
//  BasketInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol BasketInteractorProtocol {
    func makeOrder(basket: [Product : Int], completion: @escaping (NetworkingError?) -> ())
}

class BasketInteractor { }

extension BasketInteractor: BasketInteractorProtocol {
    func makeOrder(basket: [Product : Int], completion: @escaping (NetworkingError?) -> ()) {
        FirebaseHandler.shared.makeOrder(basket: basket) { (error) in
            completion(error)
        }
    }
}
