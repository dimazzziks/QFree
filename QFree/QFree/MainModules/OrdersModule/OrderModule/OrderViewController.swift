//
//  OrderViewController.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

import UIKit

protocol OrderViewProtocol: class {
    func update(_ currentOrderStatus: OrderStatus)
    func update(_ products: Products)
    func showNoInternetAlert(_ okAction: (() -> ())?)
}

class OrderViewController: BaseViewController {
    var presenter: OrderPresenter?
    
    let tableView = UITableView()
    
    var currentOrderStatus: OrderStatus? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var products: Products = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    func setupTitle() {
        self.title = "Заказ"
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        tableView.register(OrderStateCell.self, forCellReuseIdentifier: "OrderStateCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderStateCell") as! OrderStateCell
            guard let currentOrderInfo = currentOrderStatus else {
                return cell
            }
            cell.setOrderInfo(currentOrderInfo)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        let currentProduct = products[indexPath.row - 1]
        cell.configure(product: currentProduct.productInfo, amount: currentProduct.amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 450 : 150
    }
}

extension OrderViewController: OrderViewProtocol {
    func update(_ currentOrderStatus: OrderStatus) {
        self.currentOrderStatus = currentOrderStatus
    }
    
    func update(_ products: Products) {
        self.products = products
    }
}
