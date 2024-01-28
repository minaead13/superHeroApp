//
//  SearchViewController.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private var viewModel = SearchViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        tableView.registerCell(cell: SearchTableViewCell.self)
        bindTableView()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        viewModel.fetchCharacters()
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text else {
            return
        }
        
        let filteredHeroes = viewModel.heroes.value.filter { $0.name.contains(searchText) }
        viewModel.filteredHeroes.accept(filteredHeroes)
    }
    
    func bindTableView(){
        tableView.rowHeight = 80
        tableView.backgroundColor = .black
        
        viewModel.filteredHeroes
            .subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier , cellType: SearchTableViewCell.self)) { (row, item , cell) in
                
                cell.titleLabel?.text = item.name
                let imagePath = item.thumbnail?.path ?? ""
                let imageExt  = item.thumbnail?.thumbnailExtension ?? ""
                
                let imageURL  = "\(imagePath).\(imageExt)"
                cell.charImage.kf.setImage(with: URL(string: imageURL))
                cell.backgroundColor = .black
        
            }.disposed(by: bag)
        
    }
    
 

    
}
