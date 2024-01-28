//
//  NetworkLayer.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    
}

class MarvelAPI {
    
    static let shared = MarvelAPI()
    
    func fetchCharacters() -> Observable<[Results]> {
        
        return Observable.create { observer in
            let timestamp = String(Date().timeIntervalSince1970)
            let hash = "\(timestamp)\(NetwrokConstant.shared.privateKey)\(NetwrokConstant.shared.publicKey)".md5()

            var components = URLComponents(string: NetwrokConstant.shared.serverAddress)!
            components.queryItems = [
                URLQueryItem(name: "apikey", value: NetwrokConstant.shared.publicKey),
                URLQueryItem(name: "ts", value: timestamp),
                URLQueryItem(name: "hash", value: hash)
            ]

            guard let url = components.url else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(MarvelModel.self, from: data)
                        observer.onNext(responseData.data.results ?? [])
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchCharDetails(characterId : Int , entitType : String) -> Observable<[Comic]>  {
        
        return Observable.create { observer in
            let comicsEndpoint = "\(NetwrokConstant.shared.charDetailsAddress)\(characterId)/\(entitType)"
            let timestamp = String(Date().timeIntervalSince1970)
            let hash = "\(timestamp)\(NetwrokConstant.shared.privateKey)\(NetwrokConstant.shared.publicKey)".md5()
            var urlComponents = URLComponents(string: comicsEndpoint)!
            urlComponents.queryItems = [
                URLQueryItem(name: "apikey", value: NetwrokConstant.shared.publicKey),
                URLQueryItem(name: "ts", value: timestamp),
                URLQueryItem(name: "hash", value: hash)
            ]
            
            
            guard let url = urlComponents.url else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let comicsArray = json["data"] as? [String: Any], let results = comicsArray["results"] as? [[String: Any]] {
                                // Now you can parse the results array
                                let comics = try JSONDecoder().decode([Comic].self, from: JSONSerialization.data(withJSONObject: results))
                                print(comics.count)
                                observer.onNext(comics)
                                observer.onCompleted()
                            }
                        }
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
    

