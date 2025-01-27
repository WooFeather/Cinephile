//
//  NetworkManager.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func callTMDBAPI<T: Decodable>(api: TMDBRequest,
                                   type: T.Type,
                                   completionHandler: @escaping (T) -> Void,
                                   failHandler: @escaping () -> Void)
    {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print("✅ SUCCESS")
                    completionHandler(value)
                case .failure(let error):
                    print("❌ FAIL \(error)")
                    failHandler()
                }
            }
    }
}
