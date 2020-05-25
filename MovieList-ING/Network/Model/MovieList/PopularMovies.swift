//
//  PopularMovies.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct PopularMovies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let poster: String
    let title: String
    let overview: String
    let releaseDate: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case title
        case overview
        case releaseDate = "release_date"
        case id
    }
}
