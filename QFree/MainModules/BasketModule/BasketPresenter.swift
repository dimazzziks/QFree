//
//  BasketPresenter.swift
//  QFree
//
//  Created by Саид Дагалаев on 28.10.2020.
//
import  UIKit
protocol BasketPresenterProtocol {
    func makeOrder(basket: [Product : Int], time : String, completion: @escaping (NetworkingError?) -> ())
    func setTimePicker(timePicker : UIDatePicker)
}

class BasketPresenter {
    weak var view: BasketViewProtocol?
    var interactor: BasketInteractorProtocol
    var router: BasketRouterProtocol
    
    init(view: BasketViewProtocol, interactor: BasketInteractorProtocol, router: BasketRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterProtocol {
    
    func makeOrder(basket: [Product : Int], time : String, completion: @escaping (NetworkingError?) -> ()) {
        interactor.makeOrder(basket: basket, time: time) { (error) in
            completion(error)
        }
    }
    func setTimePicker(timePicker : UIDatePicker) {
        timePicker.datePickerMode = .time
        timePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        var dates = interactor.setTimePicker(timePicker: timePicker)
        timePicker.minimumDate = dates[0]
        timePicker.maximumDate = dates[1]
    }
}
