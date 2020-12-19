//
//  CachedImageView.swift
//  QFree
//
//  Created by Саид Дагалаев on 19.12.2020.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CachedImageView: UIImageView {
    let activityIndicator = UIActivityIndicatorView()
    var imageUrl: String?
    var placeholderImage = UIImage(named: "restaurant-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFill
        
        activityIndicator.startAnimating()
        activityIndicator.frame = self.bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from urlStr: String?) {
        
        guard urlStr != nil else {
            return
        }
        
        image = placeholderImage
        imageUrl = urlStr
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlStr!)) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlStr!) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err)
            } else {
                DispatchQueue.main.async {
                    let imageFromData = UIImage(data: data!)
                    if self.imageUrl == urlStr {
                        self.image = imageFromData
                        self.activityIndicator.stopAnimating()
                    }
                    imageCache.setObject(imageFromData!, forKey: NSString(string: urlStr!))
                }
            }
        }.resume()
    }
}
