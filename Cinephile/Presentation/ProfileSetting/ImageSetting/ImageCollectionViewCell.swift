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
    
    var imageSelection = UIImageView()
    
    override func configureHierarchy() {
        addSubview(imageSelection)
    }
    
    override func configureLayout() {
        imageSelection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async {
            self.imageSelection.layer.cornerRadius = self.frame.width / 2
        }
        imageSelection.clipsToBounds = true
        imageSelection.alpha = 0.5
        imageSelection.layer.borderColor = UIColor.cinePrimaryGray.cgColor
        imageSelection.layer.borderWidth = 1
    }
    
    // 이걸 쓰기 위해 만들어놓은 커스텀뷰 미사용
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageSelection.alpha = 1
                imageSelection.layer.borderColor = UIColor.cineAccent.cgColor
                imageSelection.layer.borderWidth = 3
            } else  {
                imageSelection.alpha = 0.5
                imageSelection.layer.borderColor = UIColor.cinePrimaryGray.cgColor
                imageSelection.layer.borderWidth = 1
            }
        }
    }
}
