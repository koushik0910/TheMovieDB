//
//  MovieDetailsAPIService.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 19/02/24.
//

import Foundation

import UIKit
import Foundation
import NetworkUtility

protocol MovieDetailsInteractor{
    func fetchMovieDetails(forMovieWithId id: Int)
}

protocol MovieDetailsInteractorDelegate: AnyObject {
    func fetchMovieDetailsSuccess(movies: Movie)
    func fetchMovieDetailsFailure(error: NetworkError?)
}

class MovieDetailsAPIService: MovieDetailsInteractor{
    weak var delegate: MovieDetailsInteractorDelegate?
    
    @MainActor
    func fetchMovieDetails(forMovieWithId id: Int) {
        Task {
            do {
                let queryParams = [
                    Constants.ParamKeys.apiKey : Constants.ParamValues.apiKey,
                    Constants.ParamKeys.appendToResponse: Constants.ParamValues.appendToResponse
                ]
                let apiResource = MovieDetailsResource(queryParams: queryParams, movieId: String(id))
                let request = apiResource.urlRequest
                let movie: Movie = try await NetworkUtility.shared.request(urlRequest: request)
                delegate?.fetchMovieDetailsSuccess(movies: movie)
            } catch {
                delegate?.fetchMovieDetailsFailure(error: error as? NetworkError)
            }
        }
    }
}

struct MovieDetailsResource: APIResource {
    var queryParams: [String : String]?
    var movieId: String
    init(queryParams: [String : String], movieId: String) {
        self.queryParams = queryParams
        self.movieId = movieId
    }
    var httpMethod = HTTPMethod.get
    var methodPath: String {
        return "/3/movie/\(movieId)"
    }
    var params: [String : String]?{
        return queryParams
    }
}
