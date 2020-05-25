//
//  MovieList_INGTests.swift
//  MovieList-INGTests
//
//  Created by Burak Şentürk on 25.05.2020.
//  Copyright © 2020 Burak Şentürk. All rights reserved.
//

import XCTest
@testable import MovieList_ING

class MovieList_INGTests: XCTestCase {

    var movieListViewModel: MovieListViewModel!
    var movieDetailViewModel: MovieDetailViewModel!

    override func setUpWithError() throws {
        movieListViewModel = MovieListViewModel()
        movieDetailViewModel = MovieDetailViewModel()
    }

    override func tearDownWithError() throws {
        movieListViewModel = nil
    }

    func testGetPopularMovies() throws {
        let expectation = XCTestExpectation(description: "Get popular movies")
        movieListViewModel.getMovies(page: 1)

        movieListViewModel.reloadData = {
            if self.movieListViewModel.popularMovies.isEmpty {
                XCTAssertNil("Nil")
            } else {
                XCTAssertEqual(self.movieListViewModel.popularMovies.count,
                               20)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testMovieDetail() throws {
        let expectation = XCTestExpectation(description: "Get detail of movie")

        movieDetailViewModel.getMovieDetail(with: "419704")

        movieDetailViewModel.updatePage = { movie in
            XCTAssertEqual(movie.title, "Ad Astra")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
