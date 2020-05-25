//
//  MovieListViewModel.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

final class MovieListViewModel {

    let network = Network()

    var popularMovies: [Movie] = [] {
        didSet {
            reloadData?()
        }
    }

    var reloadData: (()->())?

    func getMovies(page: Int) {
        var movieListRequest = MovieListRequest()
        let parameterDict: [String: String] = [
            "language": "en-US",
            "api_key": Constants.API.apiKey,
            "page": "\(page)"
        ]
        for i in parameterDict {
            movieListRequest.parameterQuery.append(URLQueryItem(name: i.key,
                                                                value: i.value))
        }

        network.request(from: movieListRequest) { [weak self] result in
            switch result {
            case .success(let movies):
                let popularMovies = movies as! PopularMovies
                self?.popularMovies.append(contentsOf: popularMovies.results)
            case .failure(let error):
                print(error)
            }
        }
    }

    func itemsCount() -> Int {
        return popularMovies.count
    }
}
