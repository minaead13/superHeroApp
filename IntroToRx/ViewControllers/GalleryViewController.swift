//
//  GalleryViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import UIKit

class GalleryViewController: UIViewController  {
    
    

    @IBOutlet weak var galleryCollcetionView : UICollectionView!
    
    
    var selectedCharacter: Comic?
    var allCharacters: [Comic]?
    var viewModel: GalleryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GalleryViewModel(selectedCharacter: selectedCharacter, allCharacters: allCharacters)
        setCollectionView()
        
    }
    
    private func setCollectionView(){
        galleryCollcetionView.registerCell(cell: GalleryCollectionViewCell.self)
    }
    
    
    @IBAction func didTapCancelAction(sender : Any) {
        self.dismiss(animated: true)
        
    }

    

}


extension GalleryViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfItems() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        viewModel?.configureCell(cell, at: indexPath)
        return cell
    }
    
}
