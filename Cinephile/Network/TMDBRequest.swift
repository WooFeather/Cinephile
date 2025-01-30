//
//  TMDBRequest.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trending
    case search(query: String, page: Int)
    case images(id: Int)
    case credit(id: Int)
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/day?language=ko-KR&page=1")!
        case .search(let query, let page):
            return URL(string: baseURL + "search/movie?query=\(query)&include_adult=false&language=ko-KR&page=\(page)")!
        case .images(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case .credit(id: let id):
            return URL(string: baseURL + "movie/\(id)/credits?language=ko-KR")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.TMDBAccessToken]
    }
    
    var method: HTTPMethod {
        return .get
    }
}
