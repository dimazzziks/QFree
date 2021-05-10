//
//  OrdersPresenter.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

protocol OrdersOutput {
  func loadOrders()
  func closeOrders()
  func selectCellWith(_ order: OrderInfo)
}

class OrdersPresenter {
  weak var viewController: OrdersViewInput?
  private let restaurantName: String
  private let closeAction: () -> Void
  private let splitViewUpdater: SplitViewUpdater

  init(
    _ restaurantName: String,
    closeAction: @escaping () -> Void,
    splitViewUpdater: SplitViewUpdater
  ) {
    self.restaurantName = restaurantName
    self.closeAction = closeAction
    self.splitViewUpdater = splitViewUpdater
  }
}

extension OrdersPresenter: OrdersOutput {
  func loadOrders() {
    FirebaseHandler.shared.loadAllOrders(
      by: restaurantName) { result in
      switch result {
      case .success(let orders):
        self.viewController?.orders = orders
      case .failure(let error):
        print(error)
      }
    }
  }

  func closeOrders() {
    closeAction()
  }

  func selectCellWith(_ order: OrderInfo) {
    splitViewUpdater.updateOrderInfoAction?(order)
  }
}
