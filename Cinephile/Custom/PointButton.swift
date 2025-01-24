//
//  PointButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class PointButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.cineAccent, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        backgroundColor = .clear
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 18
        }
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.cineAccent.cgColor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
