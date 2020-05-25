//
//  MovieListViewController.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            initializeCollectionView()
        }
    }

    private var isGrid: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        setupNavigationBar(title: "Contents", imageName: "grid")
    }

    private func initializeCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell().instantiateNib(), forCellWithReuseIdentifier: "MovieCell")
    }

    override func rightBarButtonAction() {
        isGrid = !isGrid
        isGrid ? setupRightBarButtonItem(imageName: "list") : setupRightBarButtonItem(imageName: "grid")
    }


    //MARK: - Collection View Delegate & Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell",
                                                      for: indexPath) as! MovieCell
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isGrid ? CGSize(width: 150, height: 200) : CGSize(width: view.frame.width, height: 150)
    }
}

