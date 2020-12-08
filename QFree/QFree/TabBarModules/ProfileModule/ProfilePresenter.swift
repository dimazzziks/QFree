//
//  ProfilePresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol {
    func changeEmail(email: String, completion: @escaping ()->())
    func changePassword(completion: @escaping ()->())
    func logOut()
}

class ProfilePresenter{
    
    var view: ProfileViewProtocol
    var interactor: ProfileInteractorProtocol
    var router: ProfileRouterProtocol
    
    var isGoingForward = false
    
    init(view: ProfileViewProtocol, interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}


extension ProfilePresenter : ProfilePresenterProtocol{
    func changeEmail(email: String, completion: @escaping () -> ()) {
        interactor.changeEmail(email: email) {
            completion()
        }
    }
    
    func logOut() {
        interactor.logOut {
            Coordinator.rootVC(vc: BaseNavigationController(rootViewController: EntranceModuleBuilder.build()))
        }
    }
    
    func changePassword(completion: @escaping ()->()){
        interactor.changePassword {
            completion()
        }
    }
}
