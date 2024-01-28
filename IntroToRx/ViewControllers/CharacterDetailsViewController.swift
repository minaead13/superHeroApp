//
//  CharacterDetailsViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import UIKit
import Kingfisher
import RxSwift

class CharacterDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
        
    var viewModel: CharacterDetailsViewModel?
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setCollectionView()
        setUI()
        
        bindComicsCollectionView()
        bindseriessCollectionView()
        bindStoriessCollectionView()
        bindEventsCollectionView()
        
        viewModel?.fetchDetailsCharactersComic()
        viewModel?.fetchDetailsCharactersSeries()
        viewModel?.fetchDetailsCharactersStories()
        viewModel?.fetchDetailsCharactersEvents()
    }
    
    private func setUI() {
        nameLbl.text = viewModel?.name
        descriptionLbl.text = viewModel?.description
        
        if let thumbnailURL = viewModel?.thumbnailURL {
            charImageView.kf.setImage(with: thumbnailURL)
        }
    }
    
    private func setNavigation(){
        if let backButtonImage = UIImage(named: "icn-nav-back-white") {
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc func backButtonTapped() {
        // Handle back button tap
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setCollectionView(){
        comicsCollectionView.registerCell(cell: CharacterCollectionViewCell.self)
        seriesCollectionView.registerCell(cell: CharacterCollectionViewCell.self)
        storiesCollectionView.registerCell(cell: CharacterCollectionViewCell.self)
        eventsCollectionView.registerCell(cell: CharacterCollectionViewCell.self)
    }
    
    func bindComicsCollectionView(){
        
        viewModel?.comicsChars
            .subscribe(on: MainScheduler.instance)
            .bind(to: comicsCollectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.identifier , cellType: CharacterCollectionViewCell.self)) { (row, item , cell) in
                
                cell.titleLabel.text = item.title
                
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.extension ?? ""
                let imageURL  = "\(imagePath).\(imageExt)"
                cell.characterImage.kf.setImage(with: URL(string: imageURL))
                
            }.disposed(by: bag)
        
        comicsCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            
            let selectedCharacter = self.viewModel?.comicsChars.value[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            
            vc.selectedCharacter = selectedCharacter
            vc.allCharacters = self.viewModel?.comicsChars.value
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }).disposed(by: bag)
        
        
    }
    
    func bindseriessCollectionView(){
        
        viewModel?.seriesChars
            .subscribe(on: MainScheduler.instance)
            .bind(to: seriesCollectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.identifier , cellType: CharacterCollectionViewCell.self)) { (row, item , cell) in
                
                cell.titleLabel.text = item.title
                
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.extension ?? ""
                
                let imageURL  = "\(imagePath).\(imageExt)"
                cell.characterImage.kf.setImage(with: URL(string: imageURL))
             
            }.disposed(by: bag)
        
        seriesCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            
            let selectedCharacter = self.viewModel?.seriesChars.value[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            
            vc.selectedCharacter = selectedCharacter
            vc.allCharacters = self.viewModel?.seriesChars.value
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }).disposed(by: bag)
    }
    
    
    func bindStoriessCollectionView(){
        
        viewModel?.storiesChars
            .subscribe(on: MainScheduler.instance)
            .bind(to: storiesCollectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.identifier , cellType: CharacterCollectionViewCell.self)) { (row, item , cell) in
                
               
                
                cell.titleLabel.text = item.title
                
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.extension ?? ""
                let imageURL  = "\(imagePath).\(imageExt)"
                
                cell.characterImage.kf.setImage(with: URL(string: imageURL))
             
            }.disposed(by: bag)
        
        storiesCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            
            let selectedCharacter = self.viewModel?.storiesChars.value[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            
            vc.selectedCharacter = selectedCharacter
            vc.allCharacters = self.viewModel?.storiesChars.value
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }).disposed(by: bag)
    }
    
    func bindEventsCollectionView(){
        
        viewModel?.eventsChars
            .subscribe(on: MainScheduler.instance)
            .bind(to: eventsCollectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.identifier , cellType: CharacterCollectionViewCell.self)) { (row, item , cell) in
                
                cell.titleLabel.text = item.title
                
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.extension ?? ""
                
                let imageURL  = "\(imagePath).\(imageExt)"
                cell.characterImage.kf.setImage(with: URL(string: imageURL))
             
            }.disposed(by: bag)
        
        eventsCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            
            let selectedCharacter = self.viewModel?.eventsChars.value[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
            
            vc.selectedCharacter = selectedCharacter
            vc.allCharacters = self.viewModel?.eventsChars.value
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }).disposed(by: bag)
    }
    

    

}
