//
//  UIImageView+EXtension.swift
//  MusicAlbum
//
//  Created by Sameer on 25/07/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    ///
    func loadThumbnail(urlSting: String?, placeHolder: UIImage?) {
        guard let url = URL(string: urlSting ?? "") else {
            self.image = placeHolder
            return
        }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        Webservices.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = placeHolder
            }
        }
    }
}
