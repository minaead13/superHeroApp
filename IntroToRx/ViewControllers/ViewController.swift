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
    
    private var viewModel = ViewModel()
    private var bag = DisposeBag()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.rowHeight = 150
        
        setUI()
        
        tableView.registerCell(cell: CharacterTableViewCell.self)
        bindTableView()
        viewModel.creatRequest()
        
//        bindTable()
//        viewModel.fetchUsers()
        
        //viewModel.heroes.accept([])
    }
    
    

    
    
    func setUI(){
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        if let navigationController = self.navigationController {
            let imageView = UIImageView(image: UIImage(named: "icn-nav-marvel"))
            imageView.contentMode = .scaleAspectFit
            
            navigationController.navigationBar.topItem?.titleView = imageView
        }
        
        
       
        
    }
    
    @objc func rightBarButtonTapped() {
        
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
            vc.character = selectedCharacter
            vc.charactersdetails = self?.viewModel.heroes.value
            vc.viewModel = CharacterDetailsViewModel(character: selectedCharacter, charactersdetails: self?.viewModel.heroes.value)

            self?.navigationController?.pushViewController(vc, animated: true)
            
    
        }).disposed(by: bag)
    }
    
}


//class CharacterDetailsVC: UIViewController {
//    
//    
//    var collection = UICollectionView(frame: .zero)
//    
//    var characters = [Results]()
//    var character: Results?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        print(characterID)
//        
//        collection.rx.items(cellIdentifier: <#T##String#>, cellType: <#T##Cell.Type#>)
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        
//        let item = characters.firstIndex(where: { $0.id = character.id })
//        collection.scrollToItem(at: IndexPath(item: item, section: 0), at: .left, animated: true)    }
//    
//}


extension UITableView {
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}
