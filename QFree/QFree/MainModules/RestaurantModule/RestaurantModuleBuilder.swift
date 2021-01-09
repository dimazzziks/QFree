//
//  RestaurantModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

class RestaurantModuleBuilder {
    static func build() -> BaseViewController {
        let view = RestaurantVC()
        let interactor = RestaurantInteractor()
        let router = RestaurantRouter(view: view)
        let presenter = RestaurantPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
