//
//  Date+.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yy.MM.dd 가입"
        return dateFormatter.string(from: self)
    }
}
