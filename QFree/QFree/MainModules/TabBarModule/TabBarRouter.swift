//
//  TabBarRouter.swift
//  QFree
//
//  Created by Саид Дагалаев on 14.12.2020.
//

import Foundation

protocol TabBarRouterProtocol {
    var viewController: TabBarProtocol { get set }
}

class TabBarRouter: TabBarRouterProtocol {
    var viewController: TabBarProtocol
    
    init(view: TabBarProtocol) {
        self.viewController = view
    }
}
