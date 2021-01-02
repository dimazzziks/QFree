//
//  ProductModel.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

struct Product: Hashable {
    let name: String
    let price: Int
    let imageLink: String
    let category: [Category]
    let restaurantID: String
    
    init(name: String, imageLink: String, price: Int, category: [Category], restaurantID: String) {
        self.name = name
        self.imageLink = imageLink
        self.category = category
        self.price = price
        self.restaurantID = restaurantID
    }
}
