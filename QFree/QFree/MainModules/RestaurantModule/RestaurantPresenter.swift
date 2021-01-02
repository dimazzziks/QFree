//
//  RestaurantPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol RestaurantPresenterProtocol {
    func viewDidLoad()
}

class RestaurantPresenter {
    weak var view: RestaurantViewProtocol?
    var interactor: RestaurantInteractorProtocol
    var router: RestaurantRouterProtocol
    
    init(view: RestaurantViewProtocol, interactor: RestaurantInteractorProtocol, router: RestaurantRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension RestaurantPresenter: RestaurantPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchRestaurantsInfo { restaurants in
            guard let restaurants = restaurants else {
                return
            }
            self.view?.update(restaurants)
        }
    }
}
