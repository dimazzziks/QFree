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
}

class OrdersPresenter {
  weak var viewController: OrdersViewInput?
  private let restaurantName: String
  private let closeAction: () -> Void

  init(
    _ restaurantName: String,
    closeAction: @escaping () -> Void
  ) {
    self.restaurantName = restaurantName
    self.closeAction = closeAction
  }
}

extension OrdersPresenter: OrdersOutput {
  func loadOrders() {
    FirebaseHandler.shared.loadOrders(
      restaurantName: restaurantName) { result in
      switch result {
      case .success(let orders):
        self.viewController?.orders = orders
      case .failure(let error):
        print(error)
      }
    }
  }

  func closeOrders() {
    self.closeAction()
  }
}
