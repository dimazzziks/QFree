//
//  ProductTableViewCell.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    var indView = UIView()
    var message : String?
    var mainImage : UIImage?
    var link : String?
    
    var backgroundViewClear : UIView = {
        var v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }()
      
    var mainView : UIView = {
        var mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
        
    }()
    
    var underMainView : UIView = {
        var mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
        
    }()
    
    var addButton : UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "addButton"), for: .normal)
        b.layer.cornerRadius = Brandbook.defaultCornerRadius
        b.layer.masksToBounds = true
        return b
    }()
    
    var productImageView : UIImageView = {
        var i = UIImageView(image: UIImage(named: "coffee"))
        i.translatesAutoresizingMaskIntoConstraints = false
        i.layer.cornerRadius = Brandbook.defaultCornerRadius
        i.layer.masksToBounds = true
        return i

    }()
    
    var labels : UIStackView = {
        var s = UIStackView()
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        s.layer.zPosition = 0
        return s
    }()
    
    var nameLabel : UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Латте"
        l.textAlignment = .left
        l.backgroundColor = .clear
        l.textColor = Brandbook.textColor
        l.font = Brandbook.font(size: 20, weight: .bold)
        return l
    }()
    
    var priceLabel : UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "199р"
        l.textAlignment = .left
        l.backgroundColor = .clear
        l.textColor = Brandbook.textColor
        l.font = Brandbook.font(size: 20, weight: .bold)
        return l
    }()
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style : style, reuseIdentifier : reuseIdentifier)
        self.backgroundColor = .clear
        self.selectedBackgroundView = backgroundViewClear
        
        mainView.addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 12).isActive = true
        addButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        mainView.addSubview(productImageView)
        productImageView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -12).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 114).isActive = true
        
        mainView.addSubview(labels)
        labels.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 12).isActive = true
        labels.rightAnchor.constraint(equalTo: productImageView.leftAnchor, constant: -12).isActive = true
        labels.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12).isActive = true
        labels.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        labels.addArrangedSubview(nameLabel)
        labels.addArrangedSubview(priceLabel)
        
        self.addSubview(underMainView)
        underMainView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        underMainView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        underMainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underMainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        underMainView.addSubview(mainView)
        mainView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainView.leftAnchor.constraint(equalTo: underMainView.leftAnchor, constant: 12).isActive = true
        mainView.rightAnchor.constraint(equalTo: underMainView.rightAnchor, constant: -12).isActive = true
        mainView.bottomAnchor.constraint(equalTo: underMainView.bottomAnchor, constant: -6).isActive = true
        mainView.topAnchor.constraint(equalTo: underMainView.topAnchor, constant: 6).isActive = true
        
        mainView.addShadow()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

