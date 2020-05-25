//
//  MovieDetailViewModel.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {

    private let network = Network()

    var updatePage: ((Movie)->())?

    func getMovieDetail(with id: String) {
        var movieDetailRequest = MovieDetailRequest()
        movieDetailRequest.path = "/3/movie/\(id)"
        let parameterDict: [String: String] = [
            "language": "en-US",
            "api_key": Constants.API.apiKey
        ]

        for i in parameterDict {
            movieDetailRequest.parameterQuery.append(URLQueryItem(name: i.key,
                                                                value: i.value))
        }

        network.request(from: movieDetailRequest) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.updatePage?(movieDetail as! Movie)
            case .failure(let error):
                print(error)
            }
        }
    }
}
