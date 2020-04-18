//
//  ImageViewExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloadImage(url: String) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: url) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.image = UIImage(assetIdentifier: .imagePlaceholder)
                    }
                    return
                }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            
            task.resume()
        }
    }
}
