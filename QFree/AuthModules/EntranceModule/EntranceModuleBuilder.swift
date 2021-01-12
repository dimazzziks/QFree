//
//  EntranceModuleBuilder.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

class EntranceModuleBuilder {
    static func build() -> BaseViewController {
        let view = EntranceViewController()
        let interactor = EntranceInteractor(authValidator: AuthValidator())
        let router = EntranceRouter(view: view)
        let presenter = EntrancePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
