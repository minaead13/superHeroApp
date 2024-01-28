//
//  CharacterDetailsViewModel.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import Foundation
import RxRelay
import RxSwift

class CharacterDetailsViewModel {
    
    var comicsChars = BehaviorRelay<[Comic]>(value: [])
    var seriesChars = BehaviorRelay<[Comic]>(value: [])
    var storiesChars = BehaviorRelay<[Comic]>(value: [])
    var eventsChars = BehaviorRelay<[Comic]>(value: [])
    
    private let api = MarvelAPI.shared
    private let bag = DisposeBag()
    
    var character: Results?
    var charactersdetails: [Results]?
    var viewModel: GalleryViewModel?
    init(character: Results?, charactersdetails: [Results]?) {
        self.character = character
        self.charactersdetails = charactersdetails
    }
    
    func fetchDetailsCharactersComic(){
        api.fetchCharDetails(characterId: charactersdetails?.first?.id ?? 0, entitType: "comics")
            .subscribe(onNext: { [weak self] characters in
                self?.comicsChars.accept(characters)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: bag)
        
    }
    
    func fetchDetailsCharactersSeries(){
        api.fetchCharDetails(characterId: charactersdetails?.first?.id ?? 0, entitType: "series")
            .subscribe(onNext: { [weak self] characters in
                self?.seriesChars.accept(characters)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: bag)
        
    }
    
    func fetchDetailsCharactersStories(){
        api.fetchCharDetails(characterId: charactersdetails?.first?.id ?? 0, entitType: "stories")
            .subscribe(onNext: { [weak self] characters in
                
                self?.storiesChars.accept(characters)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: bag)
        
    }
    
    func fetchDetailsCharactersEvents(){
        api.fetchCharDetails(characterId: charactersdetails?.first?.id ?? 0, entitType: "events")
            .subscribe(onNext: { [weak self] characters in
                self?.eventsChars.accept(characters)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: bag)
        
    }

    var name: String? {
        return character?.name
    }

    var description: String? {
        return character?.description
    }

    var thumbnailURL: URL? {
        guard let selectedCharacter = character else {
            return nil
        }
        
        if let path = selectedCharacter.thumbnail?.path, let ext = selectedCharacter.thumbnail?.thumbnailExtension {
            let urlString = "\(path).\(ext)"
            return URL(string: urlString)
        }
        return nil
    }
    
    
    
    
  
    

   
}
