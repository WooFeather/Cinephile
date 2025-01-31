//
//  MoviewBoxButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit

final class MovieBoxButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        backgroundColor = .cineMovieBtn
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 40
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
