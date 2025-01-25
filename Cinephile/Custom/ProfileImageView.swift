//
//  ImageButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

class ProfileImageView: UIImageView {

    init(isActivate: Bool = true) {
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        clipsToBounds = true
        if isActivate {
            layer.borderColor = UIColor.cineAccent.cgColor
            layer.borderWidth = 3
        } else {
            alpha = 0.5
            layer.borderColor = UIColor.cinePrimaryGray.cgColor
            layer.borderWidth = 1
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
