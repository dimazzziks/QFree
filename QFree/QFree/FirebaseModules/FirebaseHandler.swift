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
    var user : String
    
    init() {
        self.ref = Database.database().reference()
        self.user = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "")
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
                    print("i", i)
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map{ Category(rawValue: $0)!}
                    let product : Product = Product(name: i["name"] as! String , imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
                    products.append(product)
                }
            }
            completion(products)
          }) { (error) in
            completion(nil)
        }
    }
    
    func getBasket(completion: @escaping ([Product : Int]?) -> ()) {
        var basket : [Product : Int] = [Product : Int]()
        self.ref.child("Users").child(self.user).child("basket").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String:AnyObject]]

            if data != nil {
                for i in data! {
                    
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map{ Category(rawValue: $0)!}
                    let product : Product = Product(name: i["name"] as! String , imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
                    basket[product] = Int(i["amount"] as! String)
                }
            }
            completion(basket)
          }) { (error) in
            completion(nil)
        }
    }
    
    func postBasket(products : [Product : Int]) {
        var arr : [[NSString : NSObject]] = [[NSString : NSObject]]()
        for (product, amount) in products {
            var d : [NSString : NSObject] = [NSString : NSObject]()
            d["name"] = product.name as NSString
            d["image"] = product.imageLink as NSString
            d["price"] = String(product.price) as NSString
            d["restaurantID"] = product.restaurantID as NSString
            d["amount"] = String(amount) as NSString
            d["category"] = product.category.map{$0.rawValue} as NSArray
            arr.append(d)
        }
        self.ref.child("Users").child(self.user).child("basket").setValue(arr)
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
