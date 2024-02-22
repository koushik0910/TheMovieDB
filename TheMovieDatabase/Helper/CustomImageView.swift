//
//  File.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import UIKit

class CustomImageView: UIImageView {
    var task : URLSessionDataTask!
    let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String) {
        self.image = nil
        
        if let task = task {
            task.cancel()
        }
        
        if let cacheImage = cache.object(forKey: urlString as NSString) {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        task = URLSession.shared.dataTask(with: request) { data, reponse, error in
            guard let data,  let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        task.resume()
    }
}
