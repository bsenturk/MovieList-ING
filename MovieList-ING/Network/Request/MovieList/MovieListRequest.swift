//
//  MovieListRequest.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct MovieListRequest: RequestType {

    typealias Response = PopularMovies

    var path: String {
        return "3/movie/popular"
    }

    var httpMethod: HTTPMethod

    var queryItems: [URLQueryItem]?
}
