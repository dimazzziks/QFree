//
//  RegistrationRouter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

protocol RegistrationRouterProtocol {
    var viewController: RegistrationViewProtocol { get set }
}

class RegistrationRouter: RegistrationRouterProtocol {
    var viewController: RegistrationViewProtocol
    init(view: RegistrationViewProtocol) {
        self.viewController = view
    }
}
