//
//  ViewModel.swift
//  IntroToRx
//
//  Created by Mina Eid on 26/01/2024.
//

import UIKit
import RxSwift
import RxRelay

class CharacterViewModel {
    
    var heroes = BehaviorRelay<[Results]>(value: [])
    private let api = MarvelAPI.shared
    private let bag = DisposeBag()

    func fetchCharacters() {
        api.fetchCharacters()
            .subscribe(onNext: { [weak self] characters in
                self?.heroes.accept(characters)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: bag)
    }
}
