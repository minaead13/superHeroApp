//
//  CharacterCollectionViewCell.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: CharacterCollectionViewCell.self)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
}
