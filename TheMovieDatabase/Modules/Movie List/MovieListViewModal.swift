//
//  MoviesListViewModal.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation
import NetworkUtility

enum MovieListSection: Int, CaseIterable {
    case Popular = 0
    case TopRated
    
    var title: String {
        switch self {
            case .Popular  : return "What's Popular"
            case .TopRated : return "Top Rated"
        }
    }
}

protocol MovieListView: AnyObject {
    func reloadTableView()
}

protocol MovieListViewModalProtocol {
    var popularMovies: [Movie] { get }
    var topRatedMovies: [Movie] { get }
    var numberOfSections: Int { get }
    func getHeaderTitle(forSection section: MovieListSection) -> String
    func numberOfRows(inSection section: MovieListSection) -> Int
    func fetchPopularMovies()
    func fetchTopRatedMovies()
}

class MovieListViewModal: MovieListViewModalProtocol {
    private unowned let view: MovieListView
    let apiService: MovieListInteractor
    var popular: [Movie] = []
    var topRated: [Movie] = []
    
    init(view: MovieListView, apiService: MovieListInteractor) {
        self.view = view
        self.apiService = apiService
    }
    
    var popularMovies: [Movie] {
        return popular
    }
    
    var topRatedMovies: [Movie] {
        return topRated
    }
    
    var numberOfSections: Int{
        return MovieListSection.allCases.count
    }
    
    func fetchPopularMovies() {
        apiService.fetchPopularMovies()
    }
    
    func fetchTopRatedMovies() {
        apiService.fetchTopRatedMovies()
    }
    
    func numberOfRows(inSection section: MovieListSection) -> Int {
        switch section {
            case .Popular:
                return popular.isEmpty ? 0 : 1
            case .TopRated:
                return topRated.isEmpty ? 0 : 1
        }
    }
    
    func getHeaderTitle(forSection section: MovieListSection) -> String {
        return section.title
    }
}

extension MovieListViewModal: MovieListInteractorDelegate {
    func fetchTopRatedMoviesSuccess(movies: [Movie]) {
        topRated.removeAll()
        topRated.append(contentsOf: movies)
        view.reloadTableView()
    }
    
    func fetchPopularMoviesSuccess(movies: [Movie]) {
        popular.removeAll()
        popular.append(contentsOf: movies)
        view.reloadTableView()
    }
    
    func fetchTopRatedMoviesFailure(error: NetworkError?) {
        if let error{
            print(error.localizedDescription)
        }
    }
    
    func fetchPopularMoviesFailure(error: NetworkError?) {
        if let error{
            print(error.localizedDescription)
        }
    }
}
