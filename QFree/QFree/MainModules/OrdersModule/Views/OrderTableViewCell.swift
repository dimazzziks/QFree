//
//  OrderTableViewCell.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/10/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? {
        return "OrderTableViewCell"
    }

    private let restaurantImageView = CachedImageView(frame: .zero)
    private let restaurantLabel = UILabel()
    private let orderDateLabel = UILabel()

    private let shadowView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = . none

        let inset: CGFloat = 12.0
        addSubview(shadowView)
        shadowView.addShadow()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
        ])

        shadowView.addSubview(restaurantImageView)
        shadowView.addSubview(restaurantLabel)
        shadowView.addSubview(orderDateLabel)

        restaurantImageView.clipsToBounds = true
        restaurantImageView.contentMode = .scaleAspectFill
        restaurantImageView.backgroundColor = .red
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            restaurantImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            restaurantImageView.heightAnchor.constraint(equalTo: restaurantImageView.widthAnchor, multiplier: 0.6)
        ])

        restaurantLabel.textAlignment = .left
        restaurantLabel.font = Brandbook.font(size: 20, weight: .bold)
        restaurantLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restaurantLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: inset),
            restaurantLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 16),
            restaurantLabel.heightAnchor.constraint(equalToConstant: 36),
            restaurantLabel.widthAnchor.constraint(equalTo: orderDateLabel.widthAnchor),
            restaurantLabel.trailingAnchor.constraint(equalTo: orderDateLabel.leadingAnchor)
        ])

        orderDateLabel.textAlignment = .right
        orderDateLabel.font = Brandbook.font(size: 20, weight: .bold)
        orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderDateLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 16),
            orderDateLabel.heightAnchor.constraint(equalToConstant: 36),
            orderDateLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -inset)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(orderPreview: OrderPreview) {
        restaurantImageView.loadImage(from: orderPreview.imageURL)
        restaurantLabel.text = orderPreview.restaurantName
        orderDateLabel.text = orderPreview.date
    }
}
