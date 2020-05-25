//
//  MovieDetailRequest.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

struct MovieDetailRequest: RequestType {
    typealias Response = Movie

    var parameterQuery: [URLQueryItem] = []
    var urlPath: String = ""

    var path: String {
        get {
            urlPath
        }

        set {
            urlPath = newValue
        }
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
