//
//  RestaurantMenuTableViewController.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

import UIKit

class RestaurantMenuTableViewController: BaseTableViewController {
    var restaurntName = "ГРУША"
    var restaurantID: String = "1"
    var products: [Product] = []
    var basket: [Product : Int] = [Product : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear

        FirebaseHandler.shared.getProductsByIDRestaurant(id: restaurantID) { result in
            switch result {
            case .success(let products):
                self.products = products
                self.tableView.reloadData()
            case .failure(let error):
                if error == .noInternetConnection {
                    self.showNoInternetAlert()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseHandler.shared.getBasket { result in
            switch result {
            case .success(let basket):
                self.basket = basket
            case .failure(let error):
                if error == .noInternetConnection {
                    self.showNoInternetAlert()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("basket before  post", basket)
        FirebaseHandler.shared.postBasket(products: self.basket)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductTableViewCell()
        cell.nameLabel.text = String(products[indexPath.row].name)
        cell.priceLabel.text = String(products[indexPath.row].price) + "₽"
        //cell.productImageView.image = products[indexPath.row].image
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if basket[products[indexPath.row]] == nil {
            basket[products[indexPath.row]] = 0
        }
        basket[products[indexPath.row]]! += 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
