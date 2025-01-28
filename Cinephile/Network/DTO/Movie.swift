//
//  Trending.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import Foundation

// TODO: null값 대응
struct Movie: Decodable {
    let results: [MovieDetail]
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
    }
}

struct MovieDetail: Decodable {
    let backdropImage: String? // backdropImage가 null인 경우 대응
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
