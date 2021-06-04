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

  func configure(orderInfo: OrderInfo) {
    orderNumberLabel.text = "№\(orderInfo.number)"
    orderTimeLabel.text = getFormattedDate(orderInfo.date)
  }
}

private func getFormattedDate(_ timeIntervalSinceReference: String) -> String {
    let timeInterval = TimeInterval(timeIntervalSinceReference.replacingOccurrences(of: "_", with: "."))
    let date = Date(timeIntervalSinceReferenceDate: timeInterval!)
    let dateformat = DateFormatter()
    dateformat.dateFormat = "hh:mm"
    return dateformat.string(from: date)
}
