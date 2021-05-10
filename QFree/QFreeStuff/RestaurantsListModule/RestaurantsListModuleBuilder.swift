//
//  RestaurantsListModuleBuilder.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

class RestaurantsListModuleBuilder {
  static func build() -> UIViewController {
    let presenter = RestaurantsListPresenter()
    let viewController = RestaurantsListViewController(presenter: presenter)
    presenter.viewController = viewController
    return viewController
  }
}
