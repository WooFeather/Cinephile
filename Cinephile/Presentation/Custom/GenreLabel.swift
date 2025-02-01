//
//  GenreLabel.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

final class GenreLabel: UILabel {
    
    // Label의 text에 padding값 넣어주기
    private var padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .cineBackgroundGray
        font = .systemFont(ofSize: 14)
        textColor = .cineSecondaryGray
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
