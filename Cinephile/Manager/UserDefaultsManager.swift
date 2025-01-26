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
    
    // TODO: 닉네임, 가입날짜, 좋아요 개수, 프로필이미지는 어떡하지..?
}
