//
//  SplitModuleBuilder.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

class SplitModuleBuilder {
  static func build(_ restaurantName: String) -> UISplitViewController {
    let splitViewController = UISplitViewController()
    splitViewController.viewControllers = [
      makeOrdersViewController(
        restaurantName,
        closeAction: { [weak splitViewController] in
          splitViewController?.dismiss(animated: true)
        }
      ),
      makeOrderViewController()
    ]
    splitViewController.modalPresentationStyle = .fullScreen
    splitViewController.preferredDisplayMode = .oneBesideSecondary
    return splitViewController
  }

  private static func makeOrdersViewController(
    _ restaurantName: String,
    closeAction: @escaping () -> Void
  ) -> UINavigationController {
    let viewController = OrdersModuleBuilder.build(
      restaurantName,
      closeAction: closeAction
    )
    let ordersViewController = UINavigationController(rootViewController: viewController)
    viewController.title = "Заказы"
    return ordersViewController
  }

  private static func makeOrderViewController() -> UINavigationController {
    let viewController = OrderModuleBuilder.build()
    let orderViewController = UINavigationController(rootViewController: viewController)
    viewController.title = "Информация о заказе"
    return orderViewController
  }
}
