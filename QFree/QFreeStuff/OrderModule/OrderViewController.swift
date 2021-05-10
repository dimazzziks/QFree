//
//  OrderViewController.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

protocol OrderViewInput: class {
  func updateOrderInfo(_ order: OrderInfo)
}

class OrderViewController: UIViewController, OrderViewInput {

  private let label = UILabel()
  private let presenter: OrderOutput

  init(presenter: OrderOutput) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    label.text = "Выберете заказ"
  }

  func updateOrderInfo(_ order: OrderInfo) {
    label.text = order.number
  }
}
