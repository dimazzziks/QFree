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
        interactor.fetchRestaurantsInfo { result in
            switch result {
            case .success(let restaurants):
                self.view?.update(restaurants)
            case .failure(let error):
                if error == .noInternetConnection {
                    self.view?.showNoInternetAlert()
                }
            }
        }
    }
}
