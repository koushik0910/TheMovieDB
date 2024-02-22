//
//  PopularMovieCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 19/02/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var posterImage: CustomImageView!
    @IBOutlet weak var votePercentage: UILabel!
    @IBOutlet weak var circularView: UIView!
    
    static let reuseIdentifier: String = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circularView.layer.cornerRadius = 20
        circularView.clipsToBounds = true
        votePercentage.layer.cornerRadius = 19
        votePercentage.clipsToBounds = true
        posterImage.layer.cornerRadius = 10
    }
    
    func configure(with movie: Movie) {
        title.text = movie.title
        releaseDate.text = movie.releaseDate
        posterImage.loadImage(from: movie.posterFullPath)
        votePercentage.text = movie.votingPercentage
        circularView.backgroundColor = votingAverageColor(votingAverage: movie.voteAverage)
    }
    
    private func votingAverageColor(votingAverage: Double) -> UIColor {
        if votingAverage > 7 {
            return UIColor.systemGreen
        } else if votingAverage < 5 {
            return UIColor.systemRed
        } else {
            return UIColor.yellow
        }
    }

   

}
