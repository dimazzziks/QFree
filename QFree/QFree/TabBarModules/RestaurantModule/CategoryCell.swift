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
        backgroundColor = .systemIndigo
        
        setupViews()
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
    }
    
    func configure(categoryIndex: Int) {
        categoryName.text = Category(id: categoryIndex)?.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {
    func setupViews() {
        addSubview(categoryName)
        
        categoryName.frame = self.bounds
        categoryName.textColor = .white
        categoryName.textAlignment = .center
    }
}
