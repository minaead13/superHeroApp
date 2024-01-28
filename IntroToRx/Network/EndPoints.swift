//
//  EndPoints.swift
//  IntroToRx
//
//  Created by Mina Eid on 27/01/2024.
//

import Foundation

class NetwrokConstant {
    
    public static var shared : NetwrokConstant = NetwrokConstant()
    
    private init(){
        
    }
    
    public var publicKey : String {
        get {
            return "25e4ba99ab11f7c4c8ce4376b60c5178"
        }
    }
    
    public var privateKey : String {
        get {
            return "f279ca7b294b185c4b91ed9d9917d00e90783ae0"
        }
    }
    
    public var serverAddress : String {
        get {
            return "https://gateway.marvel.com/v1/public/characters"
        
        }
    }
    
    public var charDetailsAddress : String {
        get {
            return "https://gateway.marvel.com/v1/public/characters/"
        
        }
    }
    
   
    
    
}
