//
//  CharacterTableViewCell.swift
//  IntroToRx
//
//  Created by Mina Eid on 26/01/2024.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charImage: UIImageView!
    
    static let identifier = String(describing: CharacterTableViewCell.self)
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charImage.image = nil
    }
}


