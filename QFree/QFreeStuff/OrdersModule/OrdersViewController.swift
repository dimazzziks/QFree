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
    UITableViewCell()
  }
}

extension OrdersViewController: UITableViewDelegate {

}
