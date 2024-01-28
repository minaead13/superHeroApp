//
//  Model.swift
//  IntroToRx
//
//  Created by Mina Eid on 26/01/2024.
//

import Foundation
import UIKit



struct MarvelModel : Codable {
    let status: String
    let data: DataClass
    let code: Int
    let copyright, attributionText, attributionHTML, etag: String
}

// MARK: - DataClass
struct DataClass : Codable {
    let results: [Results]?
    let offset, count, total, limit: Int
}

// MARK: - Result
struct Results : Codable {
    let thumbnail: Thumbnail?
    let comics, series: Comics
    let id: Int
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    let resourceURI: String
    let description: String
  //  let modified: Date?
    let name: String
}

// MARK: - Comics
struct Comics : Codable {
    let returned: Int
    let collectionURI: String
    let items: [ComicsItem]
    let available: Int
}
// MARK: - ComicsItem
struct ComicsItem : Codable {
    let name: String
    let resourceURI: String
}

// MARK: - Stories
struct Stories : Codable {
    let returned: Int
    let collectionURI: String
    let items: [StoriesItem]
    let available: Int
}

// MARK: - StoriesItem
struct StoriesItem : Codable {
    let name: String
    let resourceURI: String
  //  let type: ItemType?
}

enum ItemType: String, Codable {
    case cover
    case empty
    case interiorStory
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    private enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement : Codable {
    let type: URLType
    let url: String
}

enum URLType: String , Codable {
    case comiclink
    case detail
    case wiki
}
