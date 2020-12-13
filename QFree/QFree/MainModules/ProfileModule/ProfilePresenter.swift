//
//  ProfilePresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol {
    func changeEmail(email: String)
    func changePassword()
    func logOut()
}

class ProfilePresenter {
    
    var view: ProfileViewProtocol
    var changeEmailview: ChangeEmailProtocol
    var interactor: ProfileInteractorProtocol
    var router: ProfileRouterProtocol
    
    var isGoingForward = false
    
    init(view: ProfileViewProtocol,changeEmailview: ChangeEmailProtocol, interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.changeEmailview = changeEmailview
        self.interactor = interactor
        self.router = router
    }
    
}


extension ProfilePresenter : ProfilePresenterProtocol{
    func changeEmail(email: String) {
        interactor.changeEmail(email: email) {
            self.changeEmailview.showAlertMessage()
        }
    }
    
    func logOut() {
        interactor.logOut {
            Coordinator.rootVC(vc: BaseNavigationController(rootViewController: EntranceModuleBuilder.build()))
        }
    }
    
    func changePassword(){
        interactor.changePassword {
            self.view.showAlertMessage()
        }
    }
}
