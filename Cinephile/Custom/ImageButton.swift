//
//  ImageButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

class ImageButton: UIButton {

    init() {
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
            self.imageView?.layer.cornerRadius = self.frame.width / 2
        }
        layer.borderColor = UIColor.cineAccent.cgColor
        layer.borderWidth = 3
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
