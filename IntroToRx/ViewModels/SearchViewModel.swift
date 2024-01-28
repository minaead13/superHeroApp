//
//  SearchViewModel.swift
//  IntroToRx
//
//  Created by Mina Eid on 28/01/2024.
//

import Foundation
 import RxSwift
import RxRelay


class SearchViewModel {
    var heroes = BehaviorRelay<[Results]>(value: [])
    let filteredHeroes = BehaviorRelay<[Results]>(value: [])
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
