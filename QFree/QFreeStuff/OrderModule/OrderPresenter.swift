//
//  OrderPresenter.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

protocol OrderOutput: class {
  func showOrderInfo(_ order: OrderInfo)
}

class OrderPresenter {
  weak var viewController: OrderViewInput?
}

extension OrderPresenter: OrderOutput {
  func showOrderInfo(_ order: OrderInfo) {
    viewController?.updateOrderInfo(order)
  }
}
