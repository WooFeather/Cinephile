//
//  UIButton+.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit

extension UIButton.Configuration {
    static func infoButtonStyle(icon: UIImage) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.image = icon
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .cinePrimaryGray
        configuration.imagePadding = 3.0
        return configuration
    }
}
