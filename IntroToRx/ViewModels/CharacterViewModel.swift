//
//  ViewModel.swift
//  IntroToRx
//
//  Created by Mina Eid on 26/01/2024.
//

import UIKit
import RxSwift
import RxRelay

//protocol UsersAPI {
//    func fetchData(url: String, completion: @escaping([User]) -> Void)
//}
//
//protocol CharacterDetailsAPI {
//    func fetchData(url: String, completion: @escaping([Results]) -> Void)
//}
//
//class NetworkLayer: UsersAPI, CharacterDetailsAPI {
//    
//    func fetchData(url: String, completion: @escaping([User]) -> Void) {
//        completion([])
//    }
//    
//    func fetchData(url: String, completion: @escaping([Results]) -> Void){
//        
//    }
//}

class ViewModel {

     var heroes = BehaviorRelay<[Results]>(value: [])
    
//    var users =  BehaviorRelay<[User]>(value: [])
//    
//    var publishUsers = PublishSubject<[User]>()
//    
//    var publish = PublishRelay<[User]>()
//    
//    let apiLayer: UsersAPI
//    
//    init(apiLayer: UsersAPI) {
//        self.apiLayer = apiLayer
//    }
    
   
    
    
    func creatRequest(){
       
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(NetwrokConstant.shared.privateKey)\(NetwrokConstant.shared.publicKey)".md5()

        var components = URLComponents(string: NetwrokConstant.shared.serverAddress)!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: NetwrokConstant.shared.publicKey),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash)
        ]
        

        guard let url = components.url else {
            print("Invalid URL")
            exit(1)
        }

        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(MarvelModel.self, from: data)
                    //print("\(responseData)")
                    self.heroes.accept(responseData.data.results ?? [])
                    
                   
                    //self.heroes.on(.next([responseData]))
                    
                    
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }

        task.resume()
    }
  

}
