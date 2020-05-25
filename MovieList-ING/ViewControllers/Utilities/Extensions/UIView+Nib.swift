//
//  UIView+Nib.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

extension UIView {
    func instantiateNib() -> UINib {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil)
    }
}
