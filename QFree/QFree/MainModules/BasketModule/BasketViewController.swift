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
    
    private var basket: [ProductInfo : Int] = [ProductInfo : Int]()
    private var products: [ProductInfo] = [ProductInfo]()
    private var orderButton = BaseButton()
    private var tableView: UITableView = UITableView()
    private var emptyBasketLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setOrderButton()
        setTableView()
        setEmptyBasketLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBasket()
    }

    private func getBasket() {
        FirebaseHandler.shared.getBasket { result in
            switch result {
            case .success(let basket):
                self.basket = basket
                self.updateUI()
            case .failure(let error):
                if error == .noInternetConnection {
                    self.showNoInternetAlert(self.getBasket)
                }
            }
        }
    }

    private func updateUI() {
        tableView.isHidden = basket.isEmpty
        orderButton.isHidden = basket.isEmpty
        emptyBasketLabel.isHidden = !basket.isEmpty
        if !basket.isEmpty {
            products = basket.map { $0.key }
            tableView.reloadData()
        }
    }
    
    private func setupTitle() {
        title = Strings.trash
    }
    
    private func setOrderButton() {
        view.addSubview(orderButton)
        orderButton.setTitle("Заказать", for: .normal)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.titleLabel?.text = "Заказать"
        orderButton.isHidden = true
        orderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        orderButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -12).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
    }

    private func setEmptyBasketLabel() {
        emptyBasketLabel.text = "Корзина пуста"
        emptyBasketLabel.textAlignment = .center
        emptyBasketLabel.font = Brandbook.font(size: 30, weight: .bold)
        emptyBasketLabel.textColor = .lightGray
        emptyBasketLabel.adjustsFontSizeToFitWidth = true
        emptyBasketLabel.minimumScaleFactor = 0.5
        emptyBasketLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyBasketLabel)
        NSLayoutConstraint.activate([
            emptyBasketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyBasketLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyBasketLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emptyBasketLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func orderButtonPressed() {
        
        presenter?.makeOrder(basket: basket, completion: { (error) in
            if let error = error {
                if error == .noInternetConnection {
                    self.showNoInternetAlert(self.orderButtonPressed)
                }
            } else {
                self.showOrderIsProcessed()
            }
        })
    }

    private func showOrderIsProcessed() {
        let orderIsProcessedViewController = OrderIsProcessedViewController()
        orderIsProcessedViewController.modalPresentationStyle = .fullScreen
        orderIsProcessedViewController.okButtonAction = {
            orderIsProcessedViewController.dismiss(animated: true)
            self.basket.removeAll()
            self.updateUI()
            self.tabBarController?.selectedIndex = 1
        }
        present(orderIsProcessedViewController, animated: true)
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -12).isActive = true
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
        cell.minusButton.isHidden = true
        let product = products[indexPath.row]
        let amount = basket[products[indexPath.row]]!
        cell.configure(product: product, amount: amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension BasketViewController: BasketViewProtocol {
    
}
