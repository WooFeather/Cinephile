//
//  Image.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import Foundation

struct Images: Decodable {
    let backdrops: [Backdrop]
    let posters: [Poster]
}

struct Backdrop: Decodable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "file_path"
    }
}

struct Poster: Decodable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "file_path"
    }
}
