//
//  RestaurantMenuTableViewController.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

import UIKit

class RestaurantMenuTableViewController: UITableViewController {
    var restaurntName = "ГРУША"
    var restaurnts = ["ГРУША" : [Product(name: "Эспрессо",  image: UIImage(named: "coffee")!, price: 123, category: [.favourite, .dessert]), Product(name: "Латте",  image: UIImage(named: "coffee")!, price: 124, category: [.favourite, .dessert])]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = .clear
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurnts[restaurntName]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductTableViewCell()
        cell.nameLabel.text = String(restaurnts[restaurntName]![indexPath.row].name)
        cell.priceLabel.text = String(restaurnts[restaurntName]![indexPath.row].price) + "₽"
        cell.productImageView.image = restaurnts[restaurntName]![indexPath.row].image
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
