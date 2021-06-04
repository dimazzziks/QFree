//
//  RestaurantsListPresenter.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import Foundation

protocol RestaurantsListOutput: class {
  func loadRestaurants()
}

class RestaurantsListPresenter {
  weak var viewController: RestaurantsListViewInput?
}

extension RestaurantsListPresenter: RestaurantsListOutput {
  func loadRestaurants() {
    FirebaseHandler.shared.getRestaurantsInfo { result in
      switch result {
      case .success(let restaurants):
        self.viewController?.restaurants = restaurants
      case .failure(let error):
        print(error)
      }
    }
  }
}
