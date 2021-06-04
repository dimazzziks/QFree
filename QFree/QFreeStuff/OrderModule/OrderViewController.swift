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

  private var order: OrderInfo? {
    didSet {
      tableView.reloadData()
      bottomPanelView.order = order
    }
  }

  private let cellID = "ProductTableViewCell"
  private let tableView: UITableView
  private let bottomPanelView: OrderInfoBottomPanel
  private let presenter: OrderOutput

  init(presenter: OrderOutput) {
    self.presenter = presenter
    self.tableView = UITableView()
    self.bottomPanelView = OrderInfoBottomPanel()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    view.addSubview(tableView)
    view.addSubview(bottomPanelView)
    setupTableView()
    setupBottomPanelView()
  }

  func updateOrderInfo(_ order: OrderInfo) {
    self.order = order
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      ProductTableViewCell.self,
      forCellReuseIdentifier: cellID
    )
    tableView.separatorColor = .clear
    tableView.allowsSelection = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomPanelView.topAnchor)
    ])
  }

  private func setupBottomPanelView() {
    bottomPanelView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomPanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomPanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bottomPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomPanelView.heightAnchor.constraint(equalToConstant: 80)
    ])
  }
}

extension OrderViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    order?.products.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let order = order else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ProductTableViewCell
    let product = order.products[indexPath.row]
    cell.configure(
      product: product.productInfo,
      amount: product.amount
    )
    return cell
  }
}

extension OrderViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    150
  }
}
