//
//  EntrancePresenter.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import Foundation

protocol EntrancePresenterProtocol {
    
}

class EntrancePresenter {
    weak var view: EntranceViewProtocol?
    var interactor: EntranceInteractorProtocol
    var router: EntranceRouterProtocol
    
    init(view: EntranceViewProtocol, interactor: EntranceInteractorProtocol, router: EntranceRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension EntrancePresenter: EntrancePresenterProtocol {
    
}
