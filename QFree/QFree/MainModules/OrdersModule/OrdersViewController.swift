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
    private var orders: [OrderInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.orders
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        FirebaseHandler.shared.getRestaurantsInfo( completion: { result in
            switch result {
            case .success(let restaurants):
                print("ok")
                self.getOrders(restaurants: restaurants)
            case .failure(let error):
                if error == .noInternetConnection {
                    //FIXME:
                   print("no internet")
                }
            }
        })
    }

    private func getOrders(restaurants : [Restaurant]) {
        FirebaseHandler.shared.getOrders(restaurants :  restaurants, completion: { result in
            switch result {
            case .success(let ordersInfo):
                self.orders = ordersInfo
            case .failure(let error):
                if error == .noInternetConnection {
                    //self.showNoInternetAlert(self.getOrders)
                    //FIXME:
                    print("no internet")
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
        cell.configure(ordersInfo: orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.width * 0.6 + 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentOrder = orders[indexPath.row]
        print(currentOrder)
        
        let orderViewController = OrderModuleBuilder.build(order: currentOrder)
        navigationController?.pushViewController(orderViewController, animated: true)
    }
}

extension OrdersViewController: OrdersViewProtocol { }
