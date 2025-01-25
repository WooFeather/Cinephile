//
//  ImageCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: BaseCollectionViewCell {
    static let id = "ImageCollectionViewCell"
    
    var imageButton = ProfileImageView(isActivate: false)
    
    override func configureHierarchy() {
        addSubview(imageButton)
    }
    
    override func configureLayout() {
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
