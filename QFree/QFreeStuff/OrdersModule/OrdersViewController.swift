//
//  OrdersViewController.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

protocol OrdersViewInput: class {
  var orders: [OrderInfo] { get set }
}

class OrdersViewController: UIViewController, OrdersViewInput {

  var orders: [OrderInfo] {
    didSet {
      tableView.reloadData()
    }
  }

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(
      OrderPreviewCell.self,
      forCellReuseIdentifier: OrderPreviewCell.reuseIdentifier
    )
    tableView.register(
      UINib(
        nibName: String(describing: OrderPreviewCell.self),
        bundle: nil
      ),
      forCellReuseIdentifier: OrderPreviewCell.reuseIdentifier
    )
    return tableView
  }()

  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Выйти", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let presenter: OrdersOutput

  init(presenter: OrdersOutput) {
    self.presenter = presenter
    self.orders = []
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setupViews()
    presenter.loadOrders()
  }

  private func setupViews() {
    view.addSubview(tableView)
    view.addSubview(closeButton)
    setupTableView()
    setupCloseButton()
  }

  private func setupTableView() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: closeButton.topAnchor)
    ])
  }

  private func setupCloseButton() {
    NSLayoutConstraint.activate([
      closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      closeButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }

  @objc private func closeAction() {
    presenter.closeOrders()
  }
}

extension OrdersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    orders.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: OrderPreviewCell.reuseIdentifier,
      for: indexPath
    ) as! OrderPreviewCell
    let currentOrderInfo = orders[indexPath.row]
    cell.configure(orderInfo: currentOrderInfo)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    70
  }
}

extension OrdersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currentOrder = orders[indexPath.row]
    presenter.updateOrderInfo(currentOrder)
  }
}
