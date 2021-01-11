//
//  TabBarController.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import UIKit

protocol TabBarProtocol: class {
    
}

class TabBarController: UITabBarController {
    var presenter: TabBarPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        let restaurantVC = UINavigationController(rootViewController: RestaurantModuleBuilder.build())
        let ordersVC = UINavigationController(rootViewController: OrdersModuleBuilder.build())
        let basketVC = UINavigationController(rootViewController: BasketModuleBuilder.build())
        let searchVC = UINavigationController(rootViewController: SearchModuleBuilder.build())
        let profileVC = UINavigationController(rootViewController: ProfileModuleBuilder.build())

        restaurantVC.title = "Рестораны"
        ordersVC.title = "Заказы"
        basketVC.title = "Корзина"
        searchVC.title = "Поиск"
        profileVC.title = "Профиль"
        
        setViewControllers([restaurantVC, ordersVC, basketVC,
//                            searchVC,
                            profileVC], animated: true)
        tabBar.tintColor = .black
        
        let barImages = ["restaurant", "order", "basket",
//                         "search",
                         "profile"]
        guard let items = tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].image = UIImage(named: barImages[i])
        }
    }
}

extension TabBarController: TabBarProtocol {
    
}
