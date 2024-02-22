//
//  MockMovieListAPIService.swift
//  TheMovieDatabaseTests
//
//  Created by Koushik Dutta on 22/02/24.
//

import Foundation
@testable import TheMovieDatabase

class MockMovieListAPIService: MovieListInteractor  {
    weak var delegate: MovieListInteractorDelegate?
    
    func fetchTopRatedMovies() {
        if let movies = getTopRatedMoviesData()?.movies{
            self.delegate?.fetchTopRatedMoviesSuccess(movies: movies)
        }
    }
    
    func fetchPopularMovies() {}
    
    func getTopRatedMoviesData() -> MovieData? {
        do {
            guard let fileUrl = Bundle.main.url(forResource: "MovieData", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: fileUrl)
            return try JSONDecoder().decode(MovieData.self, from: data)
        } catch {
            return nil
        }
    }
}
