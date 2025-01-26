//
//  MoviewBoxButton.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit

class MovieBoxButton: UIButton {
    init(like: Int) {
        super.init(frame: .zero)
        
        setTitle("\(like)개의 무비박스 보관중", for: .normal)
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
