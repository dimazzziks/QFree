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
            restaurantName: "restaurantName",
            completionTime: "completionTime",
            number: "ABC123",
            restaurantImageUrl: "https://www.hse.ru/pubs/share/direct/305134103.jpg"
        )
    }
    
    func getOrderProducts() -> Products {
        order.products
    }
}
