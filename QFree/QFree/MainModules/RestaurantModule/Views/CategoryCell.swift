//
//  CategoryCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 26.10.2020.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static var reuseId: String = "CategoryCell"
    
    public var filled: Bool = false {
        didSet {
            if filled {
                self.backgroundColor = .white
                categoryName.textColor = Brandbook.defaultColor
            } else {
                self.backgroundColor = Brandbook.defaultColor
                categoryName.textColor = .white
            }
        }
    }
    
    let categoryName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellUI()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(categoryName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.filled = false
    }
    
    func configureCellUI() {
        self.backgroundColor = Brandbook.defaultColor
        self.layer.cornerRadius = Brandbook.defaultCornerRadius
        self.clipsToBounds = true
    }
    
    func setupViews() {
        categoryName.frame = self.bounds
        categoryName.textColor = .white
        categoryName.textAlignment = .center
        categoryName.font = Brandbook.font(size: 18)
    }
    
    func configure(categoryIndex: Int, filledSet: Set<Int>) {
        categoryName.text = Category(id: categoryIndex)?.rawValue
        
        if filledSet.contains(categoryIndex) {
            self.filled = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
