//
//  SearchRouter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation

protocol SearchRouterProtocol {
    var viewController: SearchViewProtocol { get set }
}

class SearchRouter: SearchRouterProtocol {
    var viewController: SearchViewProtocol
    
    init(view: SearchViewProtocol) {
        self.viewController = view
    }
}
