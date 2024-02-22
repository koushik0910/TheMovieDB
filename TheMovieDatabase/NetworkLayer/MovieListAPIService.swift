//
//  MovieListAPIService.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import UIKit
import Foundation
import NetworkUtility

protocol MovieListInteractor{
    func fetchPopularMovies()
    func fetchTopRatedMovies()
}

protocol MovieListInteractorDelegate: AnyObject {
    func fetchPopularMoviesSuccess(movies: [Movie])
    func fetchPopularMoviesFailure(error: NetworkError?)
    
    func fetchTopRatedMoviesSuccess(movies: [Movie])
    func fetchTopRatedMoviesFailure(error: NetworkError?)
}

class MovieListAPIService: MovieListInteractor {
    
    weak var delegate: MovieListInteractorDelegate?
    
    @MainActor
    func fetchPopularMovies() {
        Task {
            do {
                let queryParams = [
                    Constants.ParamKeys.apiKey : Constants.ParamValues.apiKey
                ]
                let apiResource = PopularMovieResource(queryParams: queryParams)
                let request = apiResource.urlRequest
                let movieData: MovieData = try await NetworkUtility.shared.request(urlRequest: request)
                delegate?.fetchPopularMoviesSuccess(movies: movieData.movies)
            } catch {
                delegate?.fetchPopularMoviesFailure(error: error as? NetworkError)
            }
        }
    }
    
    @MainActor
    func fetchTopRatedMovies() {
        Task {
            do {
                let queryParams = [
                    Constants.ParamKeys.apiKey : Constants.ParamValues.apiKey
                ]
                let apiResource = TopRatedMovieResource(queryParams: queryParams)
                let request = apiResource.urlRequest
                let movieData: MovieData = try await NetworkUtility.shared.request(urlRequest: request)
                delegate?.fetchTopRatedMoviesSuccess(movies: movieData.movies)
            } catch {
                delegate?.fetchTopRatedMoviesFailure(error: error as? NetworkError)
            }
        }
    }
}


struct PopularMovieResource: APIResource {
    var queryParams: [String : String]?
    init(queryParams: [String : String]) {
        self.queryParams = queryParams
    }
    var httpMethod = HTTPMethod.get
    var methodPath = "/3/movie/popular"
    var params: [String : String]?{
        return queryParams
    }
}

struct TopRatedMovieResource: APIResource {
    var queryParams: [String : String]?
    init(queryParams: [String : String]) {
        self.queryParams = queryParams
    }
    var httpMethod = HTTPMethod.get
    var methodPath = "/3/movie/top_rated"
    var params: [String : String]?{
        return queryParams
    }
}



