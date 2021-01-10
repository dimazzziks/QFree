//
//  OrdersViewController.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

import UIKit

protocol OrdersViewProtocol: class { }

class OrdersViewController: BaseViewController {
    var presenter: OrdersPresenter?

    private let tableView = UITableView()
    private var orders: [OrderPreview] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        getOrders()
    }

    private func getOrders() {
        presenter?.getOrders(completion: { result in
            switch result {
            case .success(let orderPreviews):
                self.orders = orderPreviews
            case .failure(let error):
                if error == .noInternetConnection {
                    self.showNoInternetAlert(self.getOrders)
                }
            }
        })
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as! OrderTableViewCell
        cell.configure(orderPreview: orders[indexPath.row])
        print(orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.width * 0.6 + 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderViewController = OrderModuleBuilder.build(orderNumber: indexPath.row)
        navigationController?.pushViewController(orderViewController, animated: true)
    }
}

extension OrdersViewController: OrdersViewProtocol { }
