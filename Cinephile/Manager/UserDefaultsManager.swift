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
    
    var searchList: [String] {
        get {
            UserDefaults.standard.array(forKey: "searchList") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchList")
        }
    }
    
    var profileImage: Data {
        get {
            UserDefaults.standard.data(forKey: "profileImage") ?? Data()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "profileImage")
        }
    }
    
    var likeMovieIdList: [Int] {
        get {
            UserDefaults.standard.array(forKey: "likeMovieId") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "likeMovieId")
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
}
