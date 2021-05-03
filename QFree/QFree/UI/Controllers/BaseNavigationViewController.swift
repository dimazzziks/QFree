//
//  BaseNavigationViewController.swift
//  QFree
//
//  Created by Maxim Sidorov on 24.10.2020.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleFont()
        removeBorderUnderTitle()
    }
    
    private func setupTitleFont() {
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Brandbook.font(size: 24)
        ]
    }
    
    private func removeBorderUnderTitle() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
}
