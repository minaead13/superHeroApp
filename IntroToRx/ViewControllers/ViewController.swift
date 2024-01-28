//
//  ViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 26/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import CommonCrypto
import CryptoSwift
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CharacterViewModel()
    private var bag = DisposeBag()
    
    var id : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.registerCell(cell: CharacterTableViewCell.self)
        bindTableView()
        viewModel.fetchCharacters()
    }
    
    func setUI(){
        tableView.rowHeight = 150
        
        
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        if let navigationController = self.navigationController {
            let imageView = UIImageView(image: UIImage(named: "icn-nav-marvel"))
            imageView.contentMode = .scaleAspectFit
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.topItem?.titleView = imageView
        }
    }
    
    @objc func rightBarButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
       

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    func bindTableView(){
        viewModel.heroes
            .subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CharacterTableViewCell.identifier , cellType: CharacterTableViewCell.self)) { (row, item , cell) in
                
                cell.titleLabel?.text = item.name
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.thumbnailExtension ?? ""
                
                let imageURL  = "\(imagePath).\(imageExt)"
                cell.charImage.kf.setImage(with: URL(string: imageURL))
                cell.backgroundColor = .black
        
            }.disposed(by: bag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let selectedCharacter = self?.viewModel.heroes.value[indexPath.row]
            
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
            
            vc.viewModel = CharacterDetailsViewModel(character: selectedCharacter, charactersdetails: self?.viewModel.heroes.value)

            self?.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: bag)
    }
    
}






