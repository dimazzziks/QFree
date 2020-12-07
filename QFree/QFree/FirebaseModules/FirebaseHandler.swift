//
//  FirebaseHandler.swift
//  QFree
//
//  Created by Дмитрий on 06.12.2020.
//

import Foundation
import Firebase

class FirebaseHandler {
    var ref : DatabaseReference!
    
    init() {
        self.ref = Database.database().reference()
    }
    
    func getRestaurantsInfo(completion: @escaping ([Restaurant]?) -> ()) {
        var restaurants : [Restaurant] = []
        self.ref.child("Restaurants").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String:AnyObject]]
            if data != nil {
                for i in data! {
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map{ Category(rawValue: $0)!}
                    let restaurant : Restaurant = Restaurant(name: i["name"] as! String, image: i["image"] as! String, lat: i["lat"] as! String, long: i["long"] as! String, category: categories)
                    restaurants.append(restaurant)
                }
            }
            completion(restaurants)
          }) { (error) in
            completion(nil)
        }
    }
    
    func getProductsByIDRestaurant(id : String,completion: @escaping ([Product]?) -> ()) {
        let query = self.ref.child("Products").queryOrdered(byChild: "restaurantID").queryEqual(toValue: id)
        var products : [Product] = []
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String:AnyObject]]
            if data != nil {
                for i in data! {
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map{ Category(rawValue: $0)!}
                    let product : Product = Product(name: i["name"] as! String , imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["price"] as! String)
                    print(product)
                    products.append(product)
                }
            }
            completion(products)
          }) { (error) in
            completion(nil)
        }
    }
    
    func getProductsInBasket(email: String, completion: @escaping ([Product]?) -> ()) {
        let query = ref.child("Users").child("\"zhbannikov_dima@mailru\"")
        var products: [Product] = []
        query.observeSingleEvent(of: .value) { snapshot in
            // FIXME: fetch snapshot
            products = [
                Product(name: "1", imageLink: "1", price: 1, category: [.coffee], restaurantID: "1"),
                Product(name: "2", imageLink: "2", price: 2, category: [.coffee], restaurantID: "2"),
                Product(name: "3", imageLink: "3", price: 3, category: [.coffee], restaurantID: "3")
            ]
            completion(products)
        }
    }
    
    func getCurrentOrderInfo(email: String, completion: @escaping (OrderInfo?) ->()) {
        let query = ref.child("Users").child("\"zhbannikov_dima@mailru\"")
        var currentOrderInfo: OrderInfo?
        query.observeSingleEvent(of: .value) { snapshot in
            // FIXME: fetch snapshot
            currentOrderInfo = OrderInfo(
                restaurantName: "Name",
                completionTime: "17:00",
                number: "123",
                restaurantImageUrl: "https://www.hse.ru/pubs/share/direct/305134103.jpg"
            )
            completion(currentOrderInfo)
        }
    }
}

//SERCH
//let usersRef = self.ref.child("users")
//
//let input = "some display name"
//let query = usersRef.queryOrdered(byChild: "displayName").queryEqual(toValue: input)
//query.observeSingleEvent(of: .value, with: { snapshot in
//    for child in snapshot.children {
//        let snap = child as! DataSnapshot
//        let dict = snap.value as! [String: Any]
//        let email = dict["email"] as! String
//        let displayName = dict["displayName"] as! String
//        print(email)
//        print(displayName)
//
//        let key = snapshot.key
//        print(key)
//    }
//})
