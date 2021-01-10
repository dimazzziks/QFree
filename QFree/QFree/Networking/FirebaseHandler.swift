//
//  FirebaseHandler.swift
//  QFree
//
//  Created by Дмитрий on 06.12.2020.
//

import Foundation
import Firebase

class FirebaseHandler {
    private var reachabilityManager: ReachabilityManagerProtocol!
    private var ref: DatabaseReference!
    private var user: String!

    static var shared: FirebaseHandler = {
        let firebaseHandler = FirebaseHandler()
        firebaseHandler.reachabilityManager = ReachabilityManager()
        firebaseHandler.ref = Database.database().reference()
        firebaseHandler.user = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "")
        return firebaseHandler
    }()

    private init() { }
    
    func getRestaurantsInfo(completion: @escaping (Result<[Restaurant], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        var restaurants: [Restaurant] = []
        self.ref.child("Restaurants").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String : AnyObject]]
            if data != nil {
                for i in data! {
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map { Category(rawValue: $0)! }
                    let restaurant: Restaurant = Restaurant(name: i["name"] as! String, image: i["image"] as! String, lat: i["lat"] as! String, long: i["long"] as! String, category: categories)
                    restaurants.append(restaurant)
                }
            }
            completion(.success(restaurants))
        }) { (error) in
            completion(.failure(.invalidResponse))
        }
    }
    
    func getProductsByIDRestaurant(id: String, completion: @escaping (Result<[Product], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let query = self.ref.child("Products")
        var products: [Product] = []
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String : AnyObject]]
            if data != nil {
                for i in data! {
                    print("i", i)
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map { Category(rawValue: $0)! }
                    let product: Product = Product(name: i["name"] as! String, imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
                    if product.restaurantID == id {
                        products.append(product)
                    }
                    
                }
            }
            completion(.success(products))
        }) { (error) in
            completion(.failure(.invalidResponse))
        }
    }
    
    func getProductsInBasket(email: String, completion: @escaping (Result<[Product], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let query = ref.child("Users").child("\"zhbannikov_dima@mailru\"")
        var products: [Product] = []
        query.observeSingleEvent(of: .value) { snapshot in
            // FIXME: fetch snapshot
            products = [
                Product(name: "1", imageLink: "1", price: 1, category: [.coffee], restaurantID: "1"),
                Product(name: "2", imageLink: "2", price: 2, category: [.coffee], restaurantID: "2"),
                Product(name: "3", imageLink: "3", price: 3, category: [.coffee], restaurantID: "3")
            ]
            completion(.success(products))
        }
    }
    
    func getBasket(completion: @escaping (Result<[Product : Int], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        var basket: [Product : Int] = [Product : Int]()
        self.ref.child("Users").child(self.user).child("basket").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String: AnyObject]]
            
            if data != nil {
                for i in data! {
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map { Category(rawValue: $0)! }
                    let product: Product = Product(name: i["name"] as! String, imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
                    basket[product] = Int(i["amount"] as! String)
                }
            }
            completion(.success(basket))
        }) { (error) in
            completion(.failure(.invalidResponse))
        }
    }
    
    func postBasket(products: [Product : Int], completion: @escaping (NetworkingError?) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.noInternetConnection)
            return
        }

        var arr: [[NSString : NSObject]] = [[NSString : NSObject]]()
        for (product, amount) in products {
            var d: [NSString : NSObject] = [NSString : NSObject]()
            d["name"] = product.name as NSString
            d["image"] = product.imageLink as NSString
            d["price"] = String(product.price) as NSString
            d["restaurantID"] = product.restaurantID as NSString
            d["amount"] = String(amount) as NSString
            d["category"] = product.category.map { $0.rawValue } as NSArray
            arr.append(d)
        }
        self.ref.child("Users").child(self.user).child("basket").setValue(arr)
        completion(nil)
    }
    
    func getCurrentOrderInfo(completion: @escaping (Result<OrderInfo, NetworkingError>) ->()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let formattedEmail = getFormattedEmail(email: Auth.auth().currentUser?.email)
        let query = ref.child("Users").child(formattedEmail)
        query.observeSingleEvent(of: .value) { snapshot in
            let currentOrderInfo = OrderInfo(
                restaurantName: "Name",
                completionTime: "17:00",
                number: "123",
                restaurantImageUrl: "https://www.hse.ru/pubs/share/direct/305134103.jpg"
            )
            completion(.success(currentOrderInfo))
        }
    }

    private func getFormattedEmail(email: String?) -> String {
        return "\"\(email?.replacingOccurrences(of: ".", with: "") ?? "")\""
    }
}
