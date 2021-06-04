//
//  OrderInfoBottomPanel.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 6/4/21.
//

import UIKit

class OrderInfoBottomPanel: UIView {
  struct Strings {
    static let completeOrder = "  Завершить заказ  "
    static let orderCompleted = "  Выдан  "
  }

  var order: OrderInfo? {
    didSet {
      updateUI()
    }
  }

  private let separator = UIView()
  private let sumLabel = UILabel()
  private let completeOrderButton = BaseButton()

  private var allViews: [UIView] {
    [separator, sumLabel, completeOrderButton]
  }

  init() {
    super.init(frame: .zero)
    allViews.forEach { addSubview($0) }
    setupSeparator()
    setupSumLabel()
    setupCompletionButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupSeparator() {
    separator.isHidden = true
    separator.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    separator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      separator.leadingAnchor.constraint(equalTo: leadingAnchor),
      separator.trailingAnchor.constraint(equalTo: trailingAnchor),
      separator.topAnchor.constraint(equalTo: topAnchor),
      separator.heightAnchor.constraint(equalToConstant: 1)
    ])
  }

  private func setupSumLabel() {
    sumLabel.font = Brandbook.font()
    sumLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      sumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
      sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  private func setupCompletionButton() {
    completeOrderButton.isHidden = true
    completeOrderButton.addTarget(
      self,
      action: #selector(completeOrder),
      for: .touchUpInside
    )
    completeOrderButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      completeOrderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      completeOrderButton.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  @objc
  private func completeOrder() {
    // MARK: - обновить инфу в базе
    order?.status = 1
  }

  private func updateUI() {
    guard let order = order else {
      allViews.forEach { $0.isHidden = true}
      return
    }

    sumLabel.text = "Итого: \(order.totalPrice)"
    allViews.forEach { $0.isHidden = false }
    completeOrderButton.setTitle(
      order.isCompleted ? Strings.orderCompleted : Strings.completeOrder,
      for: .normal
    )
  }
}
