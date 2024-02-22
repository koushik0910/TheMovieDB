//
//  MovieDetailsTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 19/02/24.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "MovieDetailsTableViewCell"

    @IBOutlet weak var backdropImage: CustomImageView!
    @IBOutlet weak var posterImage: CustomImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var circularView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true
        circularView.layer.cornerRadius = 20
        circularView.clipsToBounds = true
        userScore.layer.cornerRadius = 19
        userScore.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModal: MovieDetailsViewModalProtocol) {
        guard let movie = viewModal.movie else { return }
        posterImage.loadImage(from: movie.posterFullPath)
        backdropImage.loadImage(from: movie.backdropFullPath)
        title.text = movie.title
        releaseDate.text = movie.releaseDate
        posterImage.loadImage(from: movie.posterFullPath)
        userScore.text = movie.votingPercentage
        circularView.backgroundColor = votingAverageColor(votingAverage: movie.voteAverage)
        overview.text = movie.overview
        releaseDate.text = movie.releaseDate
        genre.text = viewModal.getGenreText(fromGenres: movie.genres)
        duration.text = viewModal.runtimeText
        tagline.text = movie.tagline
    }
    
    private func votingAverageColor(votingAverage: Double) -> UIColor {
        if votingAverage > 7 {
            return UIColor.systemGreen
        }else if votingAverage < 5{
            return UIColor.systemRed
        }else{
            return UIColor.yellow
        }
    }
    
}
