//
//  RestaurantCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 24.10.2020.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static var reuseId: String = "ListCell"
    
    let restaurantImageView = UIImageView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        
        setupViews()
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
    }
    
    func configure(with restaurant: Restaurant) {
        name.text = restaurant.name
        restaurantImageView.image = restaurant.image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RestaurantCell {
    func setupViews() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let blurEffectView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        
        addSubview(restaurantImageView)
        addSubview(blurEffectView)
        addSubview(name)
        
        restaurantImageView.frame = self.bounds
        name.frame = CGRect(x: 15, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/5)
        blurEffectView.frame = CGRect(x: 0, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/4)
        
        name.textColor = .label
        name.font = Brandbook.font(size: 25, weight: .regular)
        
    }
}
