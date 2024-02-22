//
//  CrewTableViewCell.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 20/02/24.
//

import UIKit

class CastTableViewCell: UITableViewCell, SelfConfiguringCell {
    @IBOutlet weak var crewCollectionView: UICollectionView!
    static let reuseIdentifier: String = "CastTableViewCell"
    var castDetails: [Cast] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        crewCollectionView.dataSource = self
        crewCollectionView.delegate = self
        crewCollectionView.register(UINib(nibName: CrewDetailsCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CrewDetailsCollectionViewCell.reuseIdentifier)
    }
    
    
    func configure(with viewModal: MovieDetailsViewModalProtocol) {
        guard let cast = viewModal.cast else { return }
        castDetails = cast
        crewCollectionView.reloadData()
    }
}

extension CastTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? CrewDetailsCollectionViewCell else {
            fatalError("Unable to dequeue cell")
        }
        cell.configure(cast: castDetails[indexPath.item])
        return cell
    }
}

extension CastTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (self.frame.width) / 2.8
        return CGSize(width: width, height: 240)
    }
}
