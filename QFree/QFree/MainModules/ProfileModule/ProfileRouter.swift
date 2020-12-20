//
//  ProfileRouter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol ProfileRouterProtocol {
    var viewController: ProfileViewProtocol { get set }
}

class ProfileRouter: ProfileRouterProtocol {
    var viewController: ProfileViewProtocol
    
    init(view: ProfileViewProtocol, changeEmailView: ChangeEmailProtocol) {
        self.viewController = view
    }
}
