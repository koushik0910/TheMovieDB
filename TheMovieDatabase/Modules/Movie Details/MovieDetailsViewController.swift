//
//  MovieDetailsViewController.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: AppCoordinator?
    var viewModal: MovieDetailsViewModalProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: MovieDetailsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieDetailsTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: CastTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: SocialTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SocialTableViewCell.reuseIdentifier)
        viewModal.fetchMovieDetails()
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModal.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MovieDetailsSection(rawValue: section) else { return 0 }
        return viewModal.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieDetailsSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier(), for: indexPath)
        switch section {
        case .Movie:
            guard let cell = cell  as? MovieDetailsTableViewCell else { fatalError("Failed to dequeue MovieDetailsTableViewCell") }
            cell.configure(with: viewModal)
        case .Cast:
            guard let cell = cell  as? CastTableViewCell else { fatalError("Failed to dequeue CastTableViewCell") }
            cell.configure(with: viewModal)
        case .Social:
            guard let cell = cell  as? SocialTableViewCell else { fatalError("Failed to dequeue SocialTableViewCell") }
            cell.configure(with: viewModal)
        }
        return cell
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    func reloadTableView() {
        tableView.reloadData()
    }
}
