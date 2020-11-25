//
//  RestaurantsVC.swift
//  QFree
//
//  Created by Саид Дагалаев on 23.10.2020.
//

import UIKit

class RestaurantsVC: UIViewController {
    
    // TODO: Upload to Firebase
    var restaurants: [Restaurant] = [
        Restaurant(name: "Столовая", image: "https://www.hse.ru/pubs/share/direct/305134103.jpg", category: [.favourite, .dessert]),
        Restaurant(name: "Обеденный зал (1 этаж)", image: "https://www.hse.ru/pubs/share/direct/305812280.jpg", category: [.coffee, .bakery]),
        Restaurant(name: "Обеденный зал (2 этаж)", image: "https://www.hse.ru/pubs/share/direct/305813043.jpg", category: [.coffee, .bakery]),
        Restaurant(name: "Кофейня", image: "https://www.hse.ru/pubs/share/direct/305838462.jpg", category: [.coffee]),
        Restaurant(name: "Кофейня «ГРУША»", image: "https://www.hse.ru/pubs/share/direct/308136212.jpg", category: [.coffee]),
        Restaurant(name: "Кофейня JEFFREY S", image: "https://www.hse.ru/pubs/share/direct/344663514.jpg", category: [.coffee])]
    
    var restaurantsCollectionView: UICollectionView!
    var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Рестораны"
        
        self.view.backgroundColor = .systemBackground
        
        setupCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    var height: CGFloat {
        get {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return (window?.windowScene?.statusBarManager?.statusBarFrame.height)! + (self.navigationController?.navigationBar.frame.height)!
        }
    }
    
    func setupCollectionView() {
        categoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: height, width: self.view.frame.width, height: 64), collectionViewLayout: createCategoryLayout())
        categoryCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        categoryCollectionView.backgroundColor = .systemBackground
        
        let bottom = categoryCollectionView.frame.origin.y + categoryCollectionView.frame.size.height
        restaurantsCollectionView = UICollectionView(frame: CGRect(x: 0, y: bottom, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: createRestaurantLayout())
        restaurantsCollectionView.autoresizingMask = [.flexibleWidth]
        restaurantsCollectionView.backgroundColor = .systemBackground
        
        self.view.addSubview(restaurantsCollectionView)
        self.view.addSubview(categoryCollectionView)
        
        restaurantsCollectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reuseId)
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        
        categoryCollectionView.alwaysBounceVertical = false
        
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 12, bottom: height*2, trailing: 12)
        
        return section
    }

}

extension RestaurantsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 76)
    }
}

extension RestaurantsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == restaurantsCollectionView {
            return restaurants.count
        } else {
            return 6 //TODO: magic num
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == restaurantsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseId, for: indexPath) as! RestaurantCell
            let restaurant = restaurants[indexPath.row]
            cell.configure(with: restaurant)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell.configure(categoryIndex: indexPath.row)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == restaurantsCollectionView {
            pushMenuVC(name: restaurants[indexPath.row].name)
        }
    }
    
    func pushMenuVC(name: String) {
        let menuVC = RestaurantMenuTableViewController()
        menuVC.title = name
        self.navigationController?.pushViewController(menuVC, animated: true)
    }

}
