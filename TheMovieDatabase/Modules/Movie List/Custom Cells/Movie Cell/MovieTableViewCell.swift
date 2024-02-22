//
//  PolularTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 21/02/24.
//

import UIKit

protocol NavigateToMovieDetailsProtocol: AnyObject {
    func moveToMovieDetails(withMovieId id: Int)
}

class MovieTableViewCell: UITableViewCell, SelfConfiguringCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerTitle: UILabel!
    static let reuseIdentifier: String = "MovieTableViewCell"
    weak var delegate: NavigateToMovieDetailsProtocol?
    var movies: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
    func configure(headerTitle: String, movies: [Movie]){
        self.headerTitle.text = headerTitle
        self.movies = movies
        collectionView.reloadData()
    }
    
}

extension MovieTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Failed to dequeue MovieCollectionViewCell")
        }
        cell.configure(with: movies[indexPath.item])
        return cell
    }
}

extension MovieTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = movies[indexPath.item].id
        delegate?.moveToMovieDetails(withMovieId: movieId)
    }
}

extension MovieTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width  = (self.frame.width - 30) / 2.1
            return CGSize(width: width, height: 370)
        }
}
