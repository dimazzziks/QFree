//
//  SearchPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol SearchPresenterProtocol {
    
}

class SearchPresenter {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol
    var router: SearchRouterProtocol
    
    init(view: SearchViewProtocol, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
}
