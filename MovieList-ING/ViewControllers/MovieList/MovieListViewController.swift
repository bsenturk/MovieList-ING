//
//  MovieListViewController.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

final class MovieListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            initializeCollectionView()
        }
    }

    private var isGrid: Bool = false
    private let viewModel = MovieListViewModel()
    private var page: Int = 1
    private var popularMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        viewModel.getMovies(page: page)
        setClosures()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupNavigationBar() {
        setupNavigationBar(title: "Contents", imageName: "grid")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = .darkGray
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.isTranslucent = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    private func initializeCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell().instantiateNib(), forCellWithReuseIdentifier: "MovieCell")
    }

    private func setClosures() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    override func rightBarButtonAction() {
        isGrid = !isGrid
        isGrid ? setupRightBarButtonItem(imageName: "list") : setupRightBarButtonItem(imageName: "grid")
        collectionView.reloadData()
    }

    private func setCellCornerRadius(cell: UICollectionViewCell, radius: CGFloat) {
        cell.layer.cornerRadius = radius
    }


    //MARK: - Collection View Delegate & Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell",
                                                      for: indexPath) as! MovieCell
        cell.movie = viewModel.popularMovies[indexPath.item]
        isGrid ? setCellCornerRadius(cell: cell, radius: 10) : setCellCornerRadius(cell: cell, radius: 0)
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isGrid ? CGSize(width: UIScreen.main.bounds.size.width / 2 - 20,
                               height: 300) : CGSize(width: view.frame.width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return isGrid ? UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) : .zero
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.popularMovies.count - 1 {
            page += 1
            viewModel.getMovies(page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController(nibName: "MovieDetailViewController",
                                                                  bundle: nil)
        movieDetailViewController.id = viewModel.popularMovies[indexPath.item].id
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

//MARK: - Search Controller Delegate

extension MovieListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if popularMovies.isEmpty {
            popularMovies = viewModel.popularMovies
        }
        if searchController.searchBar.text != "" {
            let filteredmovies = viewModel.popularMovies.filter { $0.title.contains(searchController.searchBar.text ?? "")
            }
            viewModel.popularMovies = filteredmovies
        } else {
            viewModel.popularMovies = popularMovies
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            viewModel.popularMovies = popularMovies
    }
}

