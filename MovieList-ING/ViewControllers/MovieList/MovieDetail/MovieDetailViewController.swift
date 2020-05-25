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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetail(with: "")
        setClosures()
    }

    private func setClosures() {
        viewModel.updatePage = { [weak self] movie in
            
        }
    }

}
