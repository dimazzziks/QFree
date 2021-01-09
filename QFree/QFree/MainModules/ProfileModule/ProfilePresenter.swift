//
//  ProfilePresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//

protocol ProfilePresenterProtocol {
    func changeEmail(email: String)
    func changePassword()
    func logOut()
    func getEmail() -> String
}

class ProfilePresenter {
    var view: ProfileViewProtocol
    var changeEmailview: ChangeEmailProtocol
    var interactor: ProfileInteractorProtocol
    var router: ProfileRouterProtocol
    
    var isGoingForward = false
    
    init(view: ProfileViewProtocol, changeEmailview: ChangeEmailProtocol, interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.changeEmailview = changeEmailview
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func changeEmail(email: String) {
        interactor.changeEmail(email: email) {
            self.changeEmailview.showAlertMessage()
        }
        errorCompletion: {
            self.changeEmailview.showInfoLabel(text: "Некорректная почта")
        }
    }
    
    func logOut() {
        interactor.logOut {
            Coordinator.rootVC(vc: BaseNavigationController(rootViewController: EntranceModuleBuilder.build()))
        }
    }
    
    func changePassword() {
        interactor.changePassword {
            self.view.showAlertMessage()
        }
    }
    
    func getEmail() -> String {
        interactor.getEmail()
    }
}
