//
//  TabBarPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 14.12.2020.
//

protocol TabBarPresenterProtocol { }

class TabBarPresenter {
    weak var view: TabBarProtocol?
    var interactor: TabBarInteractorProtocol
    var router: TabBarRouterProtocol
    
    init(view: TabBarProtocol, interactor: TabBarInteractorProtocol, router: TabBarRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TabBarPresenter: TabBarPresenterProtocol { }
