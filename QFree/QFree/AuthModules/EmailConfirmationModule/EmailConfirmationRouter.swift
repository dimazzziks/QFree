//
//  EmailConfirmationRouter.swift
//  QFree
//
//  Created by User on 09.11.2020.
//

protocol EmailConfirmationRouterProtocol {
    var viewController: EmailConfirmationViewProtocol { get set }
}

class EmailConfirmationRouter: EmailConfirmationRouterProtocol {
    var viewController: EmailConfirmationViewProtocol
    
    init(view: EmailConfirmationViewProtocol) {
        self.viewController = view
    }
}
