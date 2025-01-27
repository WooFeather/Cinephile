//
//  Trending.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import Foundation

struct Trending: Decodable {
    let results: [MovieDetail]
}

struct MovieDetail: Decodable {
    let backdropImage: String
    let id: Int
    let title: String
    let overview: String
    let posterImage: String
    let genreList: [Int]
    let releaseDate: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropImage = "backdrop_path"
        case id
        case title
        case overview
        case posterImage = "poster_path"
        case genreList = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}
