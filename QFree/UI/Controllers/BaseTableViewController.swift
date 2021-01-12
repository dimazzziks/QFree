//
//  BaseTableViewController.swift
//  QFree
//
//  Created by Maxim V. Sidorov on 1/4/21.
//

import UIKit

class BaseTableViewController: UITableViewController {
    func showNoInternetAlert(_ okAction: (() -> ())?) {
        BaseViewController().showNoInternetAlert(okAction)
    }
}
