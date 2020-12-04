//
//  RestaurantModel.swift
//  QFree
//
//  Created by Саид Дагалаев on 24.10.2020.
//

import UIKit

struct Restaurant: Hashable, Codable {
    let name: String
    let image: String
    let lat: String
    let long: String
    let category: [Category]
    
    init(name: String, image: String, lat: String, long: String, category: [Category]) {
        self.name = name
        self.image = image
        self.lat = lat
        self.long = long
        self.category = category
    }
}

enum Category: String, Hashable, Codable {
    case favourite = "Избранное"
    case bakery = "Выпечка"
    case coffee = "Кофе"
    case sushi = "Суши"
    case pizza = "Пицца"
    case dessert = "Десерт"
    
    init?(id: Int) {
        switch id {
        case 0: self = .favourite
        case 1: self = .bakery
        case 2: self = .coffee
        case 3: self = .sushi
        case 4: self = .pizza
        case 5: self = .dessert
            
        default:
            return nil
        }
    }
}
