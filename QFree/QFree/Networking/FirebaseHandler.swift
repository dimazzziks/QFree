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
    private var user: String?

    static var shared: FirebaseHandler = {
        let firebaseHandler = FirebaseHandler()
        firebaseHandler.reachabilityManager = ReachabilityManager()
        firebaseHandler.ref = Database.database().reference()
        firebaseHandler.user = Auth.auth().currentUser?.email?.replacingOccurrences(of: ".", with: "")
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

    func getProductsByIDRestaurant(id: String, completion: @escaping (Result<[ProductInfo], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let query = self.ref.child("Products")
        var products: [ProductInfo] = []
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String : AnyObject]]
            if data != nil {
                for i in data! {
                    print("i", i)
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map { Category(rawValue: $0)! }
                    let product: ProductInfo = ProductInfo(name: i["name"] as! String, imageLink: i["image"] as! String, price: Int(i["price"] as! String)!, category: categories, restaurantID: i["restaurantID"] as! String)
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

    func getBasket(completion: @escaping (Result<[ProductInfo : Int], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        guard let user = user else {
            completion(.failure(.invalidResponse))
            return
        }

        var basket: [ProductInfo : Int] = [ProductInfo : Int]()
        self.ref.child("Users").child(user).child("basket").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.value as? [[String: AnyObject]]

            if data != nil {
                for i in data! {
                    let rawValues = i["category"] as! [String]
                    let categories = rawValues.map { Category(rawValue: $0)! }
                    let product: ProductInfo = ProductInfo(
                        name: i["name"] as! String,
                        imageLink: i["image"] as! String,
                        price: Int(i["price"] as! String)!,
                        category: categories,
                        restaurantID: i["restaurantID"] as! String
                    )
                    basket[product] = Int(i["amount"] as! String)
                }
            }
            completion(.success(basket))
        }) { (error) in
            completion(.failure(.invalidResponse))
        }
    }

    func postBasket(products: [ProductInfo : Int], completion: @escaping (NetworkingError?) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.noInternetConnection)
            return
        }

        guard let user = user else {
            completion(.invalidResponse)
            return
        }

        var basket: [[NSString : NSObject]] = [[NSString : NSObject]]()
        for (product, amount) in products {
            var item: [NSString : NSObject] = [NSString : NSObject]()
            item["name"] = product.name as NSString
            item["image"] = product.imageLink as NSString
            item["price"] = String(product.price) as NSString
            item["restaurantID"] = product.restaurantID as NSString
            item["amount"] = String(amount) as NSString
            item["category"] = product.category.map { $0.rawValue } as NSArray
            basket.append(item)
        }
        self.ref.child("Users").child(user).child("basket").setValue(basket)
        completion(nil)
    }

    func getCurrentOrderStatus(completion: @escaping (Result<OrderStatus, NetworkingError>) ->()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        let currentOrderInfo = OrderStatus(
            restaurantName: "Name",
            completionMessage: "17:00",
            number: "123",
            restaurantImageUrl: "https://www.hse.ru/pubs/share/direct/305134103.jpg"
        )
        completion(.success(currentOrderInfo))
    }

    func getOrders(completion: @escaping (Result<[OrderInfo], NetworkingError>) -> ()) {
        guard reachabilityManager.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }

        guard let user = user else {
            completion(.failure(.invalidResponse))
            return
        }

        let query = ref.child("Users").child(user).child("orders")
        var ordersInfo: [OrderInfo] = []
        query.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                for order in data {
                    let orders = order.value as! [String : AnyObject]
                    var products = [(productInfo: ProductInfo, amount: Int)]()
                    let responseProducts = orders["products"] as! [[String: AnyObject]]
                    for product in responseProducts {
                        let productInfo = ProductInfo(
                            name: product["name"] as! String,
                            imageLink: product["image"] as! String,
                            price: Int(product["price"] as! String)!,
                            category: (product["category"] as! [String]).map {
                                Category(rawValue: $0)!
                            },
                            restaurantID: product["restaurantID"] as! String
                        )
                        let amount = Int(product["amount"] as! String)!
                        products.append((productInfo, amount))
                    }

                    let orderInfo = orders["info"] as! [String: AnyObject]
                    ordersInfo.append(
                        OrderInfo(
                            imageURL: orderInfo["image"] as! String,
                            restaurantName: orderInfo["name"] as! String,
                            date: orderInfo["date"] as! String,
                            readyDate: orderInfo["readyDate"] as! String,
                            products: products,
                            number: orderInfo["number"] as! String,
                            status: Int(orderInfo["ready"] as! String)!

                        )
                    )
                }
            }
            self.sortOrdersInfo(&ordersInfo)
            let formattedOrdersInfo = ordersInfo.map {
                OrderInfo(
                    imageURL: $0.imageURL,
                    restaurantName: $0.restaurantName,
                    date: self.getFormattedDate($0.date),
                    readyDate: self.getFormattedDate($0.readyDate),
                    products: $0.products,
                    number: $0.number,
                    status: $0.status


                )
            }
            completion(.success(formattedOrdersInfo))
        }
    }

    func makeOrder(
        number: Int,
        basket: [ProductInfo : Int],
        restaurants : [Restaurant],
        completion: @escaping (NetworkingError?) -> ()
    ) {
        guard reachabilityManager.isConnected else {
            completion(.noInternetConnection)
            return
        }

        guard let user = user else {
            completion(.invalidResponse)
            return
        }

        getBasket { result in
            switch result {
            case .success(let basket):
                var order: [[NSString : NSObject]] = [[NSString : NSObject]]()
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

                let index = Int(Array(basket.keys)[0].restaurantID)

                let imageURL = restaurants[index!].image
                let restaurantName = restaurants[index!].name
                let calendar = Calendar.current
                let readyDate = calendar.date(byAdding: .minute, value: 30, to: Date())
                let readyDateStr = self.getTimestamp(date: readyDate!)
                let isReady = "0"

                let hash = self.getTimestamp(date:  Date())

                var info: [NSString : NSObject] = [NSString : NSObject]()
                info["image"] = imageURL as NSString
                info["name"] = restaurantName as NSString
                info["date"] = hash as NSString
                info["readyDate"] = readyDateStr as NSString
                info["number"] = String(number) as NSString
                info["ready"] = isReady as NSString

                self.ref.child("Users").child(user).child("orders").child(hash).child("products").setValue(order)
                self.ref.child("Users").child(user).child("orders").child(hash).child("info").setValue(info)
                self.ref.child("Users").child(user).child("basket").removeValue()
                completion(nil)
            case .failure(let error):
                completion(error)
                return
            }
        }
    }

    func loadAllOrders1(by restaurantName: String, completion: @escaping (Result<[OrderInfo], NetworkingError>) ->()) {
        completion(.success([
            OrderInfo(
                imageURL: "https://www.hse.ru/pubs/share/direct/305134103.jpg",
                restaurantName: "Столовая",
                date: "12:45",
                readyDate: "4.5.6",
                products: [
                    (productInfo: ProductInfo(
                        name: "Кофе",
                        imageLink: "https://static.tildacdn.com/tild6135-3262-4039-b030-373036336563/_.jpg",
                        price: 250,
                        category: [.bakery],
                        restaurantID: "0"
                    ),
                    amount: 1),
                    (productInfo: ProductInfo(
                        name: "",
                        imageLink: "",
                        price: 0,
                        category: [.bakery],
                        restaurantID: "0"
                    ),
                    amount: 3)
                ],
                number: "77",
                status: 0
            ),
            OrderInfo(
                imageURL: "https://www.hse.ru/pubs/share/direct/305134103.jpg",
                restaurantName: "",
                date: "12:41",
                readyDate: "",
                products: [
                    (productInfo: ProductInfo(
                        name: "Салат",
                        imageLink: "https://static.tildacdn.com/tild6135-3262-4039-b030-373036336563/_.jpg",
                        price: 200,
                        category: [.bakery],
                        restaurantID: ""
                    ),
                    amount: 2),
                    (productInfo: ProductInfo(
                        name: "Салат",
                        imageLink: "https://static.tildacdn.com/tild6135-3262-4039-b030-373036336563/_.jpg",
                        price: 300,
                        category: [.bakery],
                        restaurantID: "0"
                    ),
                    amount: 1)
                ],
                number: "32",
                status: 0
            )
        ]))
    }

    func loadAllOrders(by restaurantName: String, completion: @escaping (Result<[OrderInfo], NetworkingError>) ->()) {
      


        let query = ref.child("Users") //.child(user).child("orders")
        var ordersInfo: [OrderInfo] = []
        query.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                for (user, elem) in data {
                    if let newElem = elem as? [String: AnyObject] {
                        if let orders = newElem["orders"] as? [String: AnyObject] {
                            for order in orders.values {
                                if let newOrder = order as? [String: AnyObject] {
                                    if let info = newOrder["info"] as? [String: AnyObject] {
                                        if info["name"] as! String == restaurantName {
                                            
                                            
                                            var products = [(productInfo: ProductInfo, amount: Int)]()
                                            let responseProducts = newOrder["products"] as! [[String: AnyObject]]
                                            for product in responseProducts {
                                                let productInfo = ProductInfo(
                                                    name: product["name"] as! String,
                                                    imageLink: product["image"] as! String,
                                                    price: Int(product["price"] as! String)!,
                                                    category: (product["category"] as! [String]).map {
                                                        Category(rawValue: $0)!
                                                    },
                                                    restaurantID: product["restaurantID"] as! String
                                                )
                                                let amount = Int(product["amount"] as! String)!
                                                products.append((productInfo, amount))
                                            }
                                            
                                            ordersInfo.append(OrderInfo(
                                                imageURL: info["image"] as! String,
                                                restaurantName: info["name"] as! String,
                                                date: info["date"] as! String,
                                                readyDate: info["readyDate"] as! String,
                                                products: products,
                                                number: info["number"] as! String,
                                                status: Int(info["ready"] as! String)!
                                            )
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            completion(.success(ordersInfo))
        }
    }

    private func getFormattedEmail(email: String?) -> String {
        "\"\(email?.replacingOccurrences(of: ".", with: "") ?? "")\""
    }

    private func getTimestamp(date: Date) -> String {
        String(date.timeIntervalSinceReferenceDate).replacingOccurrences(of: ".", with: "_")
    }

    private func sortOrdersInfo(_ ordersInfo: inout [OrderInfo]) {
        ordersInfo.sort { (a, b) -> Bool in
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
