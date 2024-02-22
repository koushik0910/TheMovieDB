//
//  CrewDetailsCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 20/02/24.
//

import UIKit

class CrewDetailsCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {

   
    @IBOutlet weak var crewCardView: UIView!
    @IBOutlet weak var character: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: CustomImageView!
    
    static let reuseIdentifier: String = "CrewDetailsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        crewCardView.layer.cornerRadius = 10
        crewCardView.layer.masksToBounds = true
        
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }

    
    
    func configure(cast: Cast) {
        name.text = cast.name
        character.text = cast.character
        if let fullProfilePath = cast.fullProfilePath {
            profileImage.loadImage(from: fullProfilePath)
        }
    }
    

}
