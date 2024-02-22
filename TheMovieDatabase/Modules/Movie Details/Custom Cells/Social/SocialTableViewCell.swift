//
//  SocialTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 20/02/24.
//

import UIKit

class SocialTableViewCell: UITableViewCell, SelfConfiguringCell {

    @IBOutlet weak var authorImage: CustomImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var reviewView: UIView!
    
    static let reuseIdentifier: String = "SocialTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorImage.image = UIImage(systemName: "person.circle.fill")
        ratingView.layer.cornerRadius = 10
        ratingView.clipsToBounds = true
        authorImage.layer.cornerRadius = 25
    }
    
    func configure(with viewModal: MovieDetailsViewModalProtocol) {
        guard let review = viewModal.latestReview else { return }
        if let avatarPath = review.authorDetails.fullAvatarPath {
            authorImage.loadImage(from: avatarPath)
        }
        title.text = viewModal.reviewTitle
        rating.text = viewModal.ratingString
        author.text = viewModal.reviewCreatedAtText
        content.text = review.content
    }
    
}
