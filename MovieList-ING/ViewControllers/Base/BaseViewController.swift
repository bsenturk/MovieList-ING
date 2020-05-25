//
//  BaseViewController.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    func setupNavigationBar(title: String, imageName: String) {
        navigationItem.title = title
        setupRightBarButtonItem(imageName: imageName)
    }

    func setupRightBarButtonItem(imageName: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: imageName),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonAction))
    }


    @objc
    func rightBarButtonAction() {
        
    }
}
