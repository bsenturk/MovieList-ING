//
//  Constants.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

enum Constants {
    enum API {
        static let apiKey = "fd2b04342048fa2d5f728561866ad52a"
    }
    enum PosterURL {
        case poster(String, String)

        var url: String {
            switch self {
            case .poster(let width, let posterUrl):
                return "https://image.tmdb.org/t/p/w\(width)\(posterUrl)"
            }
        }
    }
}
