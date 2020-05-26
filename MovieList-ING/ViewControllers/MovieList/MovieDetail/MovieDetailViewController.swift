//
//  MovieDetailViewController.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

final class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!

    private let viewModel = MovieDetailViewModel()
    var id: Int = 0

    enum UserDefaultType {
        case set
        case remove
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLodingIndicator()
        setupNavigationBar()
        viewModel.getMovieDetail(with: "\(id)")
        setClosures()
    }

    private func setupNavigationBar() {
        let movie = UserDefaults.standard.object(forKey: "\(id)")

        if movie == nil {
            setupNavigationBar(title: "Content Details", imageName: "star")
            return
        }
        setupNavigationBar(title: "Content Details", imageName: "starFill")
    }

    override func rightBarButtonAction() {
        let movie = UserDefaults.standard.object(forKey: "\(id)")

        if movie == nil {
            userDefaultsMethod(type: .set)
        } else {
            userDefaultsMethod(type: .remove)
        }
        NotificationCenter.default.post(name: .didAddMovieToFavorite, object: nil)
    }

    private func userDefaultsMethod(type: UserDefaultType) {
        switch type {
        case .set:
            UserDefaults.standard.set(id, forKey: "\(id)")
            setupRightBarButtonItem(imageName: "starFill")
        case .remove:
            UserDefaults.standard.removeObject(forKey: "\(id)")
            setupRightBarButtonItem(imageName: "star")
        }
    }

    private func setClosures() {
        viewModel.updatePage = { [weak self] movie in
            DispatchQueue.main.async {
                let url = URL(string: Constants.PosterURL.poster("300", movie.poster).url)
                self?.movieImageView.setImage(url: url)
                self?.movieTitleLabel.text = movie.title
                self?.overviewLabel.text = movie.overview
                self?.releaseLabel.text = self?.formatReleaseDate(date: movie.releaseDate)
                self?.hideLoadingIndicator()
            }
        }
    }

    private func formatReleaseDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formattedReleaseDate = dateFormatter.date(from: date) ?? Date()

        dateFormatter.dateFormat = "dd.MM.yyyy"

        let formattedReleaseDateString = dateFormatter.string(from: formattedReleaseDate)

        return formattedReleaseDateString
    }

}
