//
//  SearchModuleBuilder.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import UIKit

class SearchModuleBuilder {
    static func build() -> UIViewController {
        let view = SearchVC()
        let interactor = SearchInteractor()
        let router = SearchRouter(view: view)
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
