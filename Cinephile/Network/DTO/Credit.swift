//
//  Credit.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import Foundation

struct Credit: Decodable {
    let cast: [CastDetail]
}

struct CastDetail: Decodable {
    let name: String
    let character: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case character
        case profileImage = "profile_path"
    }
}
