//
//  RestaurantsVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 23.10.2020.
//

import UIKit

protocol RestaurantViewProtocol: class {
    func pushMenuVC(name: String, restaurantID: String)
    func update(_ restaurants: [Restaurant])
    func showNoInternetAlert(_ okAction: (() -> ())?)
}

class RestaurantVC: BaseViewController {
    var presenter: RestaurantPresenterProtocol?
    
    var restaurants: [Restaurant] = []
    var selectedRestaurants: [Restaurant] = []
    var categories: Set<Int> = []
    
    private var restaurantsCollectionView: UICollectionView!
    private var categoryCollectionView: UICollectionView!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupActivityIndicator()
        setupCategoryCV()
        setupRestaurantsCV()
        getRestaurants()
    }
    
    func setupTitle() {
        self.title = "Рестораны"
    }
    
    func setupActivityIndicator() {
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/1.5)
        self.activityIndicator.startAnimating()
    }
    
    func getRestaurants() {
        presenter?.viewDidLoad()
    }
    
    func setupCategoryCV() {
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCategoryLayout())
        view.addSubview(categoryCollectionView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            categoryCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        categoryCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        categoryCollectionView.backgroundColor = .systemBackground
        
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        categoryCollectionView.alwaysBounceVertical = false
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func setupRestaurantsCV() {
        restaurantsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createRestaurantLayout())
        view.addSubview(restaurantsCollectionView)
        restaurantsCollectionView.addSubview(activityIndicator)
        restaurantsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantsCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            restaurantsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            restaurantsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            restaurantsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        restaurantsCollectionView.autoresizingMask = [.flexibleWidth]
        restaurantsCollectionView.backgroundColor = .systemBackground
        
        restaurantsCollectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseId)
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
    }
    
    func createRestaurantLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.createRestaurants()
        }
        
        return layout
    }
    
    func createCategoryLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.createCategories()
        }
        
        return layout
    }
    
    func createCategories() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 12)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(140), heightDimension: .estimated(40))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 0)
        
        return layoutSection
    }
    
    func createRestaurants() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(self.view.frame.width*0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: 0, trailing: 12)
        
        return section
    }
    
}

extension RestaurantVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 76)
    }
}

extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == restaurantsCollectionView {
            return selectedRestaurants.count
        } else {
            return Category.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == restaurantsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseId, for: indexPath) as! RestaurantCell
            let restaurant = selectedRestaurants[indexPath.row]
            cell.configure(with: restaurant)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell.configure(categoryIndex: indexPath.row, filledSet: categories)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == restaurantsCollectionView {
            pushMenuVC(name: selectedRestaurants[indexPath.row].name, restaurantID: String(describing: restaurants.firstIndex(of: selectedRestaurants[indexPath.row])!))
        } else {
            if categories.contains(indexPath.row) {
                categories.remove(indexPath.row)
            } else {
                categories.removeAll()
                categories.insert(indexPath.row)
            }
            categoryCollectionView.reloadData()

            if !categories.isEmpty {
                selectedRestaurants.removeAll()
                for restaurant in restaurants {
                    if restaurant.category.contains(Category.init(id: indexPath.row)!) {
                        if !selectedRestaurants.contains(restaurant) {
                            selectedRestaurants.append(restaurant)
                        }
                    }
                }
            } else {
                selectedRestaurants = restaurants
            }
            restaurantsCollectionView.reloadData()
        }
    }
}

extension RestaurantVC: RestaurantViewProtocol {
    func update(_ restaurants: [Restaurant]) {
        self.restaurants = restaurants
        self.selectedRestaurants = self.restaurants
        self.restaurantsCollectionView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    func pushMenuVC(name: String, restaurantID: String) {
        let menuVC = RestaurantMenuTableViewController()
        menuVC.title = name
        menuVC.restaurantID = restaurantID
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
}
