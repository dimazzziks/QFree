//
//  OrderModuleBuilder.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

import Foundation
import UIKit

class OrderModuleBuilder {
    static func build() -> UIViewController {
        let view = OrderViewController()
        let interactor = OrderInteractor()
        let router = OrderRouter(view: view)
        let presenter = OrderPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
