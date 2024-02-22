//
//  MovieListingViewController.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 21/02/24.
//

import UIKit

class MovieListViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AppCoordinator?
    var viewModal: MovieListViewModalProtocol!
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListTableView.dataSource = self
        movieListTableView.register(UINib(nibName: MovieTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModal.fetchPopularMovies()
        viewModal.fetchTopRatedMovies()
    }
}

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModal.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MovieListSection(rawValue: section) else { return 0 }
        return viewModal.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieListSection(rawValue: indexPath.section) else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { fatalError("Failed to dequeue MovieTableViewCell") }
        switch section {
        case .Popular:
            cell.configure(headerTitle: viewModal.getHeaderTitle(forSection: .Popular), movies: viewModal.popularMovies)
        case .TopRated:
            cell.configure(headerTitle: viewModal.getHeaderTitle(forSection: .TopRated), movies: viewModal.topRatedMovies)
        }
        cell.delegate = self
        return cell
    }
}

extension MovieListViewController: MovieListView {
    func reloadTableView() {
        movieListTableView.reloadData()
    }
}

extension MovieListViewController: NavigateToMovieDetailsProtocol {
    func moveToMovieDetails(withMovieId id: Int) {
        coordinator?.moveToMovieDetailsVC(withMovieId: id)
    }
    
    
}
