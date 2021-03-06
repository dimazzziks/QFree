//
//  OrderModuleBuilder.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

class OrderModuleBuilder {
  static func build(
    splitViewUpdater: SplitViewUpdater
  ) -> UIViewController {
    let presenter = OrderPresenter()
    splitViewUpdater.updateOrderInfo = { order in
      presenter.updateOrderInfo(order)
    }
    let viewController = OrderViewController(presenter: presenter)
    presenter.viewController = viewController
    return viewController
  }
}
