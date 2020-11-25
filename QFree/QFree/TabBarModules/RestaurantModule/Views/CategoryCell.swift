//
//  CategoryCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 26.10.2020.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static var reuseId: String = "CategoryCell"
    
    let categoryName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Brandbook.defaultColor
        
        self.layer.cornerRadius = Brandbook.defaultCornerRadius
        self.clipsToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(categoryName)
        
        categoryName.frame = self.bounds
        categoryName.textColor = .white
        categoryName.textAlignment = .center
        categoryName.font = Brandbook.font(size: 18)
    }
    
    func configure(categoryIndex: Int) {
        categoryName.text = Category(id: categoryIndex)?.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
