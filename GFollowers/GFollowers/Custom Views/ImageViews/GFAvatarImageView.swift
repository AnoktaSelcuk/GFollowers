//
//  GFAvatarImageView.swift
//  GFollowers
//
//  Created by Alperen Selçuk on 16.12.2021.
//  Copyright © 2021 Alperen Selçuk. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeHolderImage    = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds                               = true
        layer.cornerRadius                          = 10
        image                                       = placeHolderImage
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return } //datayi bunu yapmaz isek asagida kiziyor..
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
}
