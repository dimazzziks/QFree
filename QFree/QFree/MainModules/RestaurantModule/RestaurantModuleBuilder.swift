//
//  RestaurantModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import UIKit

class RestaurantModuleBuilder {
    static func build() -> UIViewController {
        let view = RestaurantVC()
        let interactor = RestaurantInteractor()
        let router = RestaurantRouter(view: view)
        let presenter = RestaurantPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
