//
//  SearchCell.swift
//  QFree
//
//  Created by Саид Дагалаев on 06.01.2021.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static var reuseId: String = "SearchCell"
    
    let mainView = UIView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(mainView)
        mainView.addSubview(name)
    }
    
    func setupViews() {
        self.frame = self.bounds
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        
        setMainView()
        setNameLabel()
    }
    
    func setMainView() {
        mainView.frame = self.bounds
        mainView.layer.cornerRadius = Brandbook.defaultCornerRadius
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = Brandbook.defaultColor
    }
    
    func setNameLabel() {
        name.frame = CGRect(x: 12, y: 12, width: self.frame.width, height: self.frame.height/5)
        name.textColor = .white
        name.font = Brandbook.font()
    }
    
    // TODO: Исправить
    func configure(with stringText: String) {
        name.text = stringText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
