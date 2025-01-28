//
//  UserDefaultsManager.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    var isSigned: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isSigned")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSigned")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var joinDate: String {
        get {
            UserDefaults.standard.string(forKey: "joinDate") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "joinDate")
        }
    }
    
    var likeCount: Int {
        get {
            UserDefaults.standard.integer(forKey: "likeCount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "likeCount")
        }
    }
    
    // 좋아요한 영화 관리를 어떻게하지
//    var likeMovieId: String {
//        get {
//            UserDefaults.standard.string(forKey: "likeMovieId") ?? ""
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "likeMovieId")
//        }
//    }
    
    // TODO: 최근검색어내역 저장
}
