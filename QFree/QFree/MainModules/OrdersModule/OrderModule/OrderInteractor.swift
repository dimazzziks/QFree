//
//  OrderInteractor.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 12/8/20.
//

protocol OrderInteractorProtocol {
    func getOrderStatus() -> OrderStatus
    func getOrderProducts() -> Products
}

class OrderInteractor {
    let order: OrderInfo
    init(order: OrderInfo) {
        self.order = order
    }
}

extension OrderInteractor: OrderInteractorProtocol {
    func getOrderStatus() -> OrderStatus {
        var completionMessage: String
        if order.status == 1 {
            completionMessage = "Готов"
        } else if order.status == 2 {
            completionMessage = "Получен"
        } else {
            completionMessage = "Будет готов к \(order.readyDate)"
        }
        return OrderStatus(
            restaurantName: order.restaurantName,
            completionMessage: completionMessage,
            number: order.number,
            restaurantImageUrl: order.imageURL
        )
    }
    
    func getOrderProducts() -> Products {
        order.products
    }
}
