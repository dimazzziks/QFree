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
    let splitViewUpdater = SplitViewUpdater()

    let ordersViewController = makeOrdersViewController(
      restaurantName,
      closeAction: { [weak splitViewController] in
        splitViewController?.dismiss(animated: true)
      },
      splitViewUpdater: splitViewUpdater
    )

    let orderViewController = makeOrderViewController(
      splitViewUpdater: splitViewUpdater
    )

    splitViewController.viewControllers = [
      ordersViewController,
      orderViewController
    ]

    splitViewController.modalPresentationStyle = .fullScreen
    splitViewController.preferredDisplayMode = .oneBesideSecondary
    return splitViewController
  }

  private static func makeOrdersViewController(
    _ restaurantName: String,
    closeAction: @escaping () -> Void,
    splitViewUpdater: SplitViewUpdater
  ) -> UINavigationController {
    let viewController = OrdersModuleBuilder.build(
      restaurantName,
      closeAction: closeAction,
      splitViewUpdater: splitViewUpdater
    )
    let ordersViewController = UINavigationController(rootViewController: viewController)
    viewController.title = "Заказы"
    return ordersViewController
  }

  private static func makeOrderViewController(
    splitViewUpdater: SplitViewUpdater
  ) -> UINavigationController {
    let viewController = OrderModuleBuilder.build(
      splitViewUpdater: splitViewUpdater
    )
    let orderViewController = UINavigationController(rootViewController: viewController)
    viewController.title = "Информация о заказе"
    return orderViewController
  }
}
