//
//  RestaurantModel.swift
//  QFree
//
//  Created by Саид Дагалаев on 24.10.2020.
//

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

enum Category: String, Hashable, Codable, CaseIterable {
    case favorite = "Избранное"
    case bakery = "Выпечка"
    case coffee = "Кофе"
    case vegan = "Здоровая"
    case first = "Первое"
    case second = "Второе"
    case pizza = "Пицца"
    case sushi = "Суши"
    case dessert = "Десерт"
    
    init?(id: Int) {
        switch id {
        case 0: self = .favorite
        case 1: self = .bakery
        case 2: self = .coffee
        case 3: self = .vegan
        case 4: self = .first
        case 5: self = .second
        case 6: self = .pizza
        case 7: self = .sushi
        case 8: self = .dessert
            
        default:
            return nil
        }
    }
}
