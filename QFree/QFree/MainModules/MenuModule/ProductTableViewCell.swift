//
//  ProductTableViewCell.swift
//  QFree
//
//  Created by Дмитрий on 09.11.2020.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    var indView = UIView()
    var message: String?
    var mainImage: UIImage?
    var link: String?
    var buttonAddCallback: () -> ()  = { }
    var buttonMinusCallback: () -> ()  = { }

    
    override var reuseIdentifier: String? {
        return String(describing: self)
    }
    
    var backgroundViewClear: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    var mainView: UIView = {
        var mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.backgroundColor = .white
        return mv
    }()
    
    var underMainView: UIView = {
        var mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    var addButton: UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "addButton"), for: .normal)
        b.layer.cornerRadius = Brandbook.defaultCornerRadius
        b.layer.masksToBounds = true
        return b
    }()
    
    var minusButton: UIButton = {
        var b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "minusButton"), for: .normal)
        b.layer.cornerRadius = Brandbook.defaultCornerRadius
        b.layer.masksToBounds = true
        return b
    }()
    
    var amountLabel: UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "1"
        l.textAlignment = .center
        l.backgroundColor = Brandbook.defaultColor
        l.textColor = .white
        l.font = Brandbook.font(size: 20, weight: .bold)
        l.layer.cornerRadius = Brandbook.defaultCornerRadius
        l.layer.masksToBounds = true
        return l
    }()
    
    var productImageView: UIImageView = {
        var i = UIImageView(image: UIImage(named: "meal"))
        i.translatesAutoresizingMaskIntoConstraints = false
        i.layer.cornerRadius = Brandbook.defaultCornerRadius
        i.layer.masksToBounds = true
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    var labels: UIStackView = {
        var s = UIStackView()
        s.axis = .vertical
        s.spacing = 6
        s.alignment = .fill
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        s.layer.zPosition = 0
        return s
    }()
    
    var nameLabel: UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Латте"
        l.textAlignment = .left
        l.backgroundColor = .clear
        l.textColor = Brandbook.textColor
        l.font = Brandbook.font(size: 20, weight: .bold)
        return l
    }()
    
    var priceLabel: UILabel = {
        var l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "199р"
        l.textAlignment = .left
        l.backgroundColor = .clear
        l.textColor = Brandbook.textColor
        l.font = Brandbook.font(size: 20, weight: .bold)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        mainView.addSubview(amountLabel)
        amountLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 12).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        mainView.addSubview(productImageView)
        productImageView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -12).isActive = true
        
        mainView.addSubview(addButton)
        addButton.leftAnchor.constraint(equalTo: amountLabel.rightAnchor, constant: 12).isActive = true
        addButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        
        mainView.addSubview(minusButton)
        minusButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 12).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        minusButton.addTarget(self, action: #selector(handleMinusButton), for: .touchUpInside)
        
        let gestureMinusButton = UITapGestureRecognizer(target: self, action:  #selector(self.handleMinusButton))
        minusButton.addGestureRecognizer(gestureMinusButton)
        
       
        productImageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 114).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        
        mainView.addSubview(labels)
        labels.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 12).isActive = true
        labels.rightAnchor.constraint(equalTo: productImageView.leftAnchor, constant: -12).isActive = true
        labels.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12).isActive = true
        labels.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        labels.addArrangedSubview(nameLabel)
        labels.addArrangedSubview(priceLabel)
        
        contentView.addSubview(underMainView)
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
    
    func configure(product: ProductInfo, amount: Int) {
        nameLabel.text = String(product.name)
        priceLabel.text = String(product.price) + "₽"
        amountLabel.text = "\(amount)"
      
        let imageURL: URL = URL(string: product.imageLink)!
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: data)!
                }
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleAddButton() {
        buttonAddCallback()
    }
    
    @objc func handleMinusButton() {
        buttonMinusCallback()
    }
    
}

