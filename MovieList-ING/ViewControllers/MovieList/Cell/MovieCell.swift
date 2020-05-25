//
//  MovieCell.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!

    var movie: Movie? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    enum ImageType: String {
        case none
        case starFill
    }

    private func updateCell() {
        let url = URL(string: Constants.PosterURL.poster("400", movie?.poster ?? "").url)
        movieImageView.setImage(url: url)

        movieTitle.text = movie?.title

        let isFavorite = UserDefaults.standard.object(forKey: "\(movie?.id ?? 0)")

        isFavorite == nil ? setStarImage(imageType: .none) : setStarImage(imageType: .starFill)
    }

    private func setStarImage(imageType: ImageType) {
        favoriteImageView.image = UIImage(named: imageType.rawValue)
    }

}
