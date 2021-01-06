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
    let whiteView = UIView()
    let name = UILabel()
    
    var restaurantImageView: CachedImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(mainView)
        mainView.addSubview(restaurantImageView)
        mainView.addSubview(whiteView)
        mainView.addSubview(name)
    }
    
    func setupViews() {
        addShadow()
        setMainView()
        setImageView()
        setWhiteView()
        setNameLabel()
    }
    
    func setMainView() {
        mainView.frame = self.bounds
        mainView.layer.cornerRadius = Brandbook.defaultCornerRadius
        mainView.layer.masksToBounds = true
    }
    
    func setImageView() {
        restaurantImageView = CachedImageView(frame: self.bounds)
    }
    
    func setWhiteView() {
        whiteView.frame = CGRect(x: 0, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/4)
        whiteView.backgroundColor = .white
    }
    
    func setNameLabel() {
        name.frame = CGRect(x: 15, y: self.frame.height - self.frame.height/5, width: self.frame.width, height: self.frame.height/5)
        name.textColor = Brandbook.textColor
        name.font = Brandbook.font()
    }
    
    func configure(with restaurant: Restaurant) {
        name.text = restaurant.name
        restaurantImageView.imageUrl = restaurant.image
        restaurantImageView.loadImage(from: restaurantImageView.imageUrl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
