//
//  RestaurantCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 24.10.2020.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static var reuseId: String = "ListCell"
    
    let mainView = UIView()
    let underMainView = UIView()
    let restaurantImageView = UIImageView()
    let whiteView = UIView()
    let name = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        activityIndicator.startAnimating()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(underMainView)
        underMainView.addSubview(mainView)
        mainView.addSubview(restaurantImageView)
        restaurantImageView.addSubview(activityIndicator)
        restaurantImageView.contentMode = .scaleAspectFill
        mainView.addSubview(whiteView)
        mainView.addSubview(name)
    }
    
    func setupViews() {
        underMainView.frame = self.bounds
        underMainView.layer.shadowColor = UIColor.black.cgColor
        underMainView.layer.shadowOpacity = 0.3
        underMainView.layer.shadowOffset = .zero
        underMainView.layer.shadowRadius = 5
        
        mainView.frame = self.bounds
        mainView.layer.cornerRadius = Brandbook.defaultCornerRadius
        mainView.layer.masksToBounds = true
        
        restaurantImageView.frame = self.bounds
        
        activityIndicator.frame = self.bounds
        
        whiteView.frame = CGRect(x: 0, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/4)
        whiteView.backgroundColor = .white
        
        name.frame = CGRect(x: 15, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/5)
        name.textColor = Brandbook.textColor
        name.font = Brandbook.font()
    }
    
    func configure(with restaurant: Restaurant) {
        name.text = restaurant.name
        
        let imageURL: URL = URL(string: restaurant.image)!
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.restaurantImageView.image = UIImage(data: data)!
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
