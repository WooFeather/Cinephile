//
//  UserDefaultsManager.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
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
    
//    var profileImage: Data {
//        get {
//            UserDefaults.standard.data(forKey: "profileImage") ?? Data()
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "profileImage")
//        }
//    }
}
