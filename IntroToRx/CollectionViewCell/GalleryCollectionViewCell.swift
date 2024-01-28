//
//  GalleryCollectionViewCell.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    

    static let identifier = String(describing: GalleryCollectionViewCell.self)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        galleryImageView.image = nil
    }

}
