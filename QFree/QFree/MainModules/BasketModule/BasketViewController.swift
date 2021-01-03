//
//  BasketVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 27.10.2020.
//

import UIKit

protocol BasketViewProtocol: class {
    
}

class BasketViewController: BaseViewController {
    var presenter: BasketPresenterProtocol?
    
    var basket: [Product : Int] = [Product : Int]()
    var products: [Product] = [Product]()
    var orderButton = BaseButton()
    var tableView1: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setOrderButton()
        setTabelView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseHandler.shared.getBasket { result in
            switch result {
            case .success(let basket):
                self.basket = basket
                self.products = basket.map{$0.key}
                self.tableView1.reloadData()
            case .failure(let error):
                if error == .noInternetConnection {
                    self.showNoInternetAlert()
                }
            }
        }
    }
    
    func setupTitle() {
        self.title = "Корзина"
    }
    
    func setOrderButton() {
        self.view.addSubview(orderButton)
        self.orderButton.setTitle("Заказать", for: .normal)
        self.orderButton.translatesAutoresizingMaskIntoConstraints = false
        self.orderButton.titleLabel?.text = "Заказать"
        self.orderButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        self.orderButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        self.orderButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:  -12).isActive = true
        self.orderButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    func setTabelView() {
        self.view.addSubview(tableView1)
        self.tableView1.separatorColor = .clear
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView1.translatesAutoresizingMaskIntoConstraints = false
        self.tableView1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView1.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView1.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView1.bottomAnchor.constraint(equalTo: self.orderButton.topAnchor, constant: -12).isActive = true
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductTableViewCell()
        cell.nameLabel.text = String(products[indexPath.row].name)
        cell.priceLabel.text = String(products[indexPath.row].price) + "₽"
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.addButton.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension BasketViewController: BasketViewProtocol {
    
}
