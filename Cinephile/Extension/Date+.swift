//
//  Date+.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

extension Date {
    func toJoinString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yy.MM.dd 가입"
        return dateFormatter.string(from: self)
    }
    
    func toReleaseString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy. MM. dd"
        return dateFormatter.string(from: self)
    }
}
