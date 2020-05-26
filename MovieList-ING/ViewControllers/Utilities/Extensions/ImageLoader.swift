//
//  ImageLoader.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImage(url: URL?) {
        guard let url = url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async {
                if let data = data {
                    let imageCache = NSCache<NSString, UIImage>()
                    if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: "\(url)"))
                    self.image = downloadedImage
                    }
                }
            }
        }.resume()
    }
}
