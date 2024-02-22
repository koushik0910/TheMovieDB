//
//  AppCoordinator.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieListVC = MovieListViewController.instantiate()
        movieListVC.coordinator = self
        let apiService = MovieListAPIService()
        let movieListVM = MovieListViewModal(view: movieListVC, apiService: apiService)
        apiService.delegate = movieListVM
        movieListVC.viewModal = movieListVM
        navigationController.pushViewController(movieListVC, animated: true)
    }
    
    func moveToMovieDetailsVC(withMovieId id: Int) {
        let movieDetailsVC = MovieDetailsViewController.instantiate()
        let apiService = MovieDetailsAPIService()
        let movieDetailsVM = MovieDetailsViewModal(movieId: id, view: movieDetailsVC, apiService: apiService)
        apiService.delegate = movieDetailsVM
        movieDetailsVC.viewModal = movieDetailsVM
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
