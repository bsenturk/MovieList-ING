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
            }

            guard let data = data else { return }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }

        }.resume()
    }
}
