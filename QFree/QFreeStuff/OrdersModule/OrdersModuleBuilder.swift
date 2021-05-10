//
//  OrdersModuleBuilder.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

class OrdersModuleBuilder {
  static func build(
    _ restaurantName: String,
    closeAction: @escaping () -> Void
  ) -> UIViewController {
    let presenter = OrdersPresenter(
      restaurantName,
      closeAction: closeAction
    )
    let viewController = OrdersViewController(presenter: presenter)
    presenter.viewController = viewController
    return viewController
  }
}
