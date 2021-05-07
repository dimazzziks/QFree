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
        OrderStatus(
            restaurantName: order.restaurantName,
            completionTime: order.date,
            number: order.number,
            restaurantImageUrl: order.imageURL
        )
    }
    
    func getOrderProducts() -> Products {
        order.products
    }
}
