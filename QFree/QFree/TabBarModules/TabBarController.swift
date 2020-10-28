//
//  TabBarController.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let restaurantVC = UINavigationController(rootViewController: RestaurantsVC())
        let ordersVC = UINavigationController(rootViewController: OrdersVC())
        let basketVC = UINavigationController(rootViewController: BasketVC())
        let searchVC = UINavigationController(rootViewController: SearchVC())
        let profileVC = UINavigationController(rootViewController: ProfileVC())
        
        //restaurantVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        restaurantVC.title = "Рестораны"
        ordersVC.title = "Заказы"
        basketVC.title = "Корзина"
        searchVC.title = "Поиск"
        profileVC.title = "Профиль"
        
        setViewControllers([restaurantVC, ordersVC, basketVC, searchVC, profileVC], animated: true)
        tabBar.tintColor = .systemIndigo
        
        let barImages = ["restaurant", "order", "basket", "search", "profile"]
        guard let items = tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].image = UIImage(named: barImages[i])
        }
    }
}
