//
//  BaseViewController.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let containerView = UIView()

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


    private func createLoadingIndicator() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        containerView.backgroundColor = .clear

        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0.75
        shapeLayer.lineWidth = 2

        containerView.layer.addSublayer(shapeLayer)

        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.duration = 0.3
        basicAnimation.fromValue = 0
        basicAnimation.toValue = CGFloat(Double.pi * 2)
        basicAnimation.repeatCount = .infinity
        containerView.layer.add(basicAnimation, forKey: "rotation")
    }

    func showLodingIndicator() {
        createLoadingIndicator()
    }

    func hideLoadingIndicator() {
        containerView.removeFromSuperview()
    }

}
