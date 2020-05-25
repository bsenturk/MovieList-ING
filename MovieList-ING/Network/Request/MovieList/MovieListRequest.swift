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

    var parameterQuery: [URLQueryItem] = []

    var path: String {
        return "/3/movie/popular"
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        get {
            parameterQuery
        }
        set {
            parameterQuery = newValue ?? []
        }
    }
}
