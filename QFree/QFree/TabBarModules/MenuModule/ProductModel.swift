//
//  ProductModel.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

import Foundation
import UIKit

struct Product: Hashable {
    let name: String
    let price: Int
    let image: UIImage
    let category: [Category]
    
    init(name: String, image: UIImage, price : Int, category: [Category]) {
        self.name = name
        self.image = image
        self.category = category
        self.price = price
    }
}


