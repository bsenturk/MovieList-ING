//
//  Network.swift
//  MovieList-ING
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

protocol RequestType {
    associatedtype Response: Decodable
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension RequestType {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "api.themoviedb.org"
    }
}

final class Network {

    func request<Request>(from request: Request, completion: @escaping (Result<Decodable, Error>) -> Void) where Request: RequestType {

        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems

        let url = urlComponents.url!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                completion(.failure(error))
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    do {
                        guard let data = data else { return }
                        let decodedValue = try JSONDecoder().decode(Request.Response.self,
                                                                    from: data)
                        completion(.success(decodedValue))
                    } catch {
                        completion(.failure(error))
                    }
                default:
                    break
                }
            }

        }.resume()
    }
}
