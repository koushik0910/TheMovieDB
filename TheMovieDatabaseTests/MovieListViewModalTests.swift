//
//  MovieListViewModalTests.swift
//  TheMovieDatabaseTests
//
//  Created by Koushik Dutta on 22/02/24.
//

import XCTest
@testable import TheMovieDatabase

final class MovieListViewModalTests: XCTestCase {
    var apiService : MockMovieListAPIService!
    var view : MockMovieListView!
    var viewModal : MovieListViewModal!
    
    override func setUpWithError() throws {
        apiService = MockMovieListAPIService()
        view = MockMovieListView()
        viewModal = MovieListViewModal(view: view, apiService: apiService)
        apiService.delegate = viewModal
        viewModal.fetchTopRatedMovies()
    }
    
    func testAPISuccess() {
        XCTAssert(viewModal.topRatedMovies.count == 5)
    }
    
    func testNumberOfRows() {
        XCTAssert(viewModal.numberOfRows(inSection: .TopRated) == 1)
        XCTAssert(viewModal.numberOfRows(inSection: .Popular) == 0)
    }
    
    func testHeaderTitle(){
        XCTAssert(viewModal.getHeaderTitle(forSection: .TopRated) == MovieListSection.TopRated.title)
    }

}
