//
//  RestaurantInteractor.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol RestaurantInteractorProtocol {
    func fetchRestaurantsInfo(completion: @escaping ([Restaurant]?) -> ())
}

class RestaurantInteractor {
    var firebaseHandler = FirebaseHandler()
}

extension RestaurantInteractor: RestaurantInteractorProtocol {
    func fetchRestaurantsInfo(completion: @escaping ([Restaurant]?) -> ()) {
        firebaseHandler.getRestaurantsInfo { restaurants in
            completion(restaurants)
        }
    }
}
