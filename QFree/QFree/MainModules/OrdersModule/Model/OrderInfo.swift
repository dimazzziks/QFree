//
//  OrderInfo.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

import Foundation

typealias Products = [(productInfo: ProductInfo, amount: Int)]

struct OrderInfo {
    var imageURL: String
    var restaurantName: String
    var date: String
    var readyDate : String
    var products: Products
    var number: String
    var status: Int
}

extension OrderInfo {
  var totalPrice: Int {
    products.reduce(0) {
      $0 + $1.productInfo.price * $1.amount
    }
  }

  var isCompleted: Bool {
    status == 1
  }
}
