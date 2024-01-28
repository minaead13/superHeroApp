//
//  SearchTableViewCell.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charImage: UIImageView!
    
    static let identifier = String(describing: SearchTableViewCell.self)
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charImage.image = nil
    }
}
