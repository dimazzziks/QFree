//
//  InfoLabel.swift
//  QFree
//
//  Created by Саид Дагалаев on 17.12.2020.
//

import UIKit

class InfoLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = Brandbook.font(size: 16, weight: .bold)
        textColor = .red
        alpha = 0.0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showInfoLabel(text: String) {
        self.text = text
        
        let animationDuration: TimeInterval = 0.3
        let delayDuration: TimeInterval = 3
        
        UIView.animate(withDuration: animationDuration) {
            self.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: animationDuration, delay: delayDuration, animations: {
                self.alpha = 0.0
            }, completion: nil)
        }
    }
}
