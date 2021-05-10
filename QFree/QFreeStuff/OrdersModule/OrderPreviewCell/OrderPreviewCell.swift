//
//  OrderPreviewCell.swift
//  QFreeStuff
//
//  Created by Maxim V. Sidorov on 5/10/21.
//

import UIKit

class OrderPreviewCell: UITableViewCell {

  static var reuseIdentifier: String {
    String(describing: self)
  }

  override var reuseIdentifier: String? {
    Self.reuseIdentifier
  }

  @IBOutlet weak var orderNumberLabel: UILabel!
  @IBOutlet weak var orderTimeLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configure(orderInfo: OrderInfo) {
    orderNumberLabel.text = orderInfo.number
    orderTimeLabel.text = orderInfo.date
  }
}
