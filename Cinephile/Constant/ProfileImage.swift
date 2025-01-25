//
//  ProfileImage.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

enum ProfileImage: CaseIterable {
    case image1
    case image2
    case image3
    case image4
    case image5
    case image6
    case image7
    case image8
    case image9
    case image10
    case image11
    case image12
    
    var image: UIImage {
        switch self {
        case .image1:
            return .profile0
        case .image2:
            return .profile1
        case .image3:
            return .profile2
        case .image4:
            return .profile3
        case .image5:
            return .profile4
        case .image6:
            return .profile5
        case .image7:
            return .profile6
        case .image8:
            return .profile7
        case .image9:
            return .profile8
        case .image10:
            return .profile9
        case .image11:
            return .profile10
        case .image12:
            return .profile11
        }
    }
}
