//
//  ImageButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        clipsToBounds = true
        layer.borderColor = UIColor.cineAccent.cgColor
        layer.borderWidth = 3
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
