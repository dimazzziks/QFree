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
                    let product: Product = Product(name: i["name"] as! String, imageLink: i["image"] as! String, price: Int(i["price"] as! String)!,time: i["time"] as! Int, category: categories, restaurantID: i["restaurantID"] as! String)
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
                Product(name: "1", imageLink: "1", price: 1, time: 15, category: [.coffee], restaurantID: "1"),
                Product(name: "2", imageLink: "2", price: 2, time: 15, category: [.coffee], restaurantID: "2"),
                Product(name: "3", imageLink: "3", price: 3, time: 15, category: [.coffee], restaurantID: "3")
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
                    let product: Product = Product(name: i["name"] as! String, imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, time: Int(i["time"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
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

        var basket: [[NSString : NSObject]] = [[NSString : NSObject]]()
        for (product, amount) in products {
            var item: [NSString : NSObject] = [NSString : NSObject]()
            item["name"] = product.name as NSString
            item["image"] = product.imageLink as NSString
            item["price"] = String(product.price) as NSString
            item["time"] = String(product.time) as NSString
            item["restaurantID"] = product.restaurantID as NSString
            item["amount"] = String(amount) as NSString
            item["category"] = product.category.map { $0.rawValue } as NSArray
            basket.append(item)
        }
        self.ref.child("Users").child(self.user).child("basket").setValue(basket)
        completion(nil)
    }
    
    func getCurrentOrderInfo(completion: @escaping (Result<OrderInfo, NetworkingError>) ->()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let currentOrderInfo = OrderInfo(
            restaurantName: "Name",
            completionTime: "17:00",
            number: "123",
            restaurantImageUrl: "https://www.hse.ru/pubs/share/direct/305134103.jpg"
        )
        completion(.success(currentOrderInfo))
    }

    func getOrders(restaurants : [Restaurant], completion: @escaping (Result<[OrderPreview], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let query = ref.child("Users").child(self.user).child("orders")
        var orderPreviews: [OrderPreview] = []
        query.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                for order in data {
                    let p = order.value as! [[String : AnyObject]]
                    let ind = Int(p[0]["restaurantID"]! as! String)
                    let image = restaurants[ind as! Int].image
                    let name = restaurants[ind as! Int].name
                    orderPreviews.append(
                        OrderPreview(
                            imageURL: image,
                            restaurantName: name,
                            date: order.key
                        )
                    )
                }
            }
            self.sortOrderPreviews(&orderPreviews)
            let formattedOrderPreviews = orderPreviews.map {
                OrderPreview(
                    imageURL: $0.imageURL,
                    restaurantName: $0.restaurantName,
                    date: self.getFormattedDate($0.date)
                )
            }
            completion(.success(formattedOrderPreviews))
        }
    }

    func makeOrder(basket: [Product : Int], time : String, completion: @escaping (NetworkingError?) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.noInternetConnection)
            return
        }

        getBasket { result in
            switch result {
            case .success(let basket):
                var order: [[NSString : NSObject]] = [[NSString : NSObject]]()
                order.append(["time": time as NSString])
                for (product, amount) in basket {
                    var item: [NSString : NSObject] = [NSString : NSObject]()
                    item["name"] = product.name as NSString
                    item["image"] = product.imageLink as NSString
                    item["price"] = String(product.price) as NSString
                    item["restaurantID"] = product.restaurantID as NSString
                    item["amount"] = String(amount) as NSString
                    item["category"] = product.category.map { $0.rawValue } as NSArray
                    order.append(item)
                }
                self.ref.child("Users").child(self.user).child("orders").child(self.getTimestamp()).setValue(order)
                self.ref.child("Users").child(self.user).child("basket").removeValue()
                completion(nil)
            case .failure(let error):
                completion(error)
                return
            }
        }
    }

    private func getFormattedEmail(email: String?) -> String {
        return "\"\(email?.replacingOccurrences(of: ".", with: "") ?? "")\""
    }

    private func getTimestamp() -> String {
        return String(Date.timeIntervalSinceReferenceDate).replacingOccurrences(of: ".", with: "_")
    }

    private func sortOrderPreviews(_ orderPreviews: inout [OrderPreview]) {
        orderPreviews.sort { (a, b) -> Bool in
            let firstDate = Double(a.date.replacingOccurrences(of: "_", with: "."))!
            let secondDate = Double(b.date.replacingOccurrences(of: "_", with: "."))!
            return firstDate > secondDate
        }
    }

    private func getFormattedDate(_ timeIntervalSinceReference: String) -> String {
        let timeInterval = TimeInterval(timeIntervalSinceReference.replacingOccurrences(of: "_", with: "."))
        let date = Date(timeIntervalSinceReferenceDate: timeInterval!)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy hh:mm"
        return dateformat.string(from: date)
    }
}
