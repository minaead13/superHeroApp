//
//  GalleryViewModel.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import Foundation

class GalleryViewModel {
    
    var selectedCharacter: Comic?
    var allCharacters: [Comic]?

    init(selectedCharacter: Comic?, allCharacters: [Comic]?) {
        self.selectedCharacter = selectedCharacter
        self.allCharacters = allCharacters
    }

    func getNumberOfItems() -> Int {
        return (allCharacters?.count ?? 0) + 1
    }

    func configureCell(_ cell: GalleryCollectionViewCell, at indexPath: IndexPath) {
        
        if indexPath.item == 0, let selectedCharacter = selectedCharacter {
            let imagePath = selectedCharacter.thumbnail?.path ?? ""
            let imageExt = selectedCharacter.thumbnail?.extension ?? ""
            let imageURL = "\(imagePath).\(imageExt)"
            
            cell.galleryImageView.kf.setImage(with: URL(string: imageURL))
            cell.titleLabel.text = selectedCharacter.title
        } else if let allCharacters = allCharacters, indexPath.item - 1 < allCharacters.count {
            let currentCharacter = allCharacters[indexPath.item - 1]
            let imagePath = currentCharacter.thumbnail?.path ?? ""
            let imageExt = currentCharacter.thumbnail?.extension ?? ""
            let imageURL = "\(imagePath).\(imageExt)"
            
            cell.galleryImageView.kf.setImage(with: URL(string: imageURL))
            cell.titleLabel.text = currentCharacter.title
        }
    }
}
