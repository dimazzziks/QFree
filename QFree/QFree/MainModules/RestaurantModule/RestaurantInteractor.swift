//
//  RestaurantInteractor.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol RestaurantInteractorProtocol {
    func fetchRestaurantsInfo(completion: @escaping (Result<[Restaurant], NetworkingError>) -> ())
}

class RestaurantInteractor { }

extension RestaurantInteractor: RestaurantInteractorProtocol {
    func fetchRestaurantsInfo(completion: @escaping (Result<[Restaurant], NetworkingError>) -> ()) {
        FirebaseHandler.shared.getRestaurantsInfo { result in
            completion(result)
        }
    }
}
