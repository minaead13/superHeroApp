//
//  CharacterDetailsViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    

    var character: Results?
    var charactersdetails: [Results]?
    
    var viewModel: CharacterDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setCollectionView()
        
       
    }
    
    private func setUI() {
        nameLbl.text = viewModel?.name
        descriptionLbl.text = viewModel?.description
        
        if let thumbnailURL = viewModel?.thumbnailURL {
            charImageView.kf.setImage(with: thumbnailURL)
        }
    }
    
//    private func setUI(){
//        nameLbl.text = character?.name
//        descriptionLbl.text = character?.description
//        
//        let imagePath = character?.thumbnail?.path ?? ""
//        let imageExt  = character?.thumbnail?.thumbnailExtension ?? ""
//        let imageURL  = "\(imagePath).\(imageExt)"
//        charImageView.kf.setImage(with: URL(string: imageURL))
//    }
    
    private func setCollectionView(){
        let cellNib = UINib(nibName: "CharacterCollectionViewCell", bundle: nil)
        comicsCollectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        seriesCollectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        storiesCollectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        eventsCollectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
    }

    

}
extension CharacterDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let thumbnailURLs = viewModel?.thumbnailURLsForAllCharacters() ?? []

        if !thumbnailURLs.isEmpty, indexPath.item < thumbnailURLs.count {
            cell.characterImage.kf.setImage(with: thumbnailURLs[indexPath.item])
        }

        switch collectionView {
            
        case comicsCollectionView:
            
            if let comicsItem = viewModel?.comics?[indexPath.row] {
                cell.titleLabel.text = comicsItem.name
            }
            
        case seriesCollectionView:
            
            if let seriesItem = viewModel?.series?[indexPath.row] {
                cell.titleLabel.text = seriesItem.name
            }
            
        case storiesCollectionView:
            
            if let storiesItem = viewModel?.stories?[indexPath.row] {
                cell.titleLabel.text = storiesItem.name
            }
            
        case eventsCollectionView:
            
            if let eventsItem = viewModel?.events?[indexPath.row] {
                cell.titleLabel.text = eventsItem.name
            }
            
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case comicsCollectionView:
            return viewModel?.comics?.count ?? 0
            
        case seriesCollectionView:
            return viewModel?.series?.count ?? 0
            
        case storiesCollectionView:
            return viewModel?.stories?.count ?? 0
            
        case eventsCollectionView:
            return viewModel?.events?.count ?? 0
            
        default:
            return 0
        }
    }

}
