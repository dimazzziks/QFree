//
//  EntranceRouter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

protocol EntranceRouterProtocol {
    var viewController: EntranceViewProtocol { get set }
}

class EntranceRouter: EntranceRouterProtocol {
    var viewController: EntranceViewProtocol
    init(view: EntranceViewProtocol) {
        self.viewController = view
    }
}
