//
//  BasketInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//
import UIKit
protocol BasketInteractorProtocol {
    func makeOrder(basket: [Product : Int], time : String, completion: @escaping (NetworkingError?) -> ())
    func setTimePicker(timePicker : UIDatePicker) -> [Date]
}

class BasketInteractor {
    
}

extension BasketInteractor: BasketInteractorProtocol {
    func makeOrder(basket: [Product : Int], time : String, completion: @escaping (NetworkingError?) -> ()) {
        FirebaseHandler.shared.makeOrder(basket: basket, time: time) { (error) in
            completion(error)
        }
    }
    func setTimePicker(timePicker : UIDatePicker) -> [Date]{
        let currentTime = Date()
        let calendar = Calendar.current
        var currentHour = calendar.component(.hour, from: currentTime)
        var currentMinute = calendar.component(.minute, from: currentTime)
        if currentHour > 21{
            currentHour = 9
            currentMinute = 0
        }
        let minComponents = NSDateComponents()
        minComponents.hour = currentHour
        minComponents.minute = currentMinute
        let minimumDate = calendar.date(from: minComponents as DateComponents)
        let maxComponents = NSDateComponents()
        maxComponents.hour = 21
        maxComponents.minute = 0
        let maximumDate = calendar.date(from: maxComponents as DateComponents)
        return [minimumDate!, maximumDate!]
    }
}
