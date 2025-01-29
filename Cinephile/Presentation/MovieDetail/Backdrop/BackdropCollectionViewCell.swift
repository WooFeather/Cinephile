//
//  BackdropCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class BackdropCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "BackdropCollectionViewCell"
    let backdropImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(backdropImageView)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        // TODO: 추후 configureData에서 실제 이미지 들어올 예정
        backdropImageView.image = UIImage(systemName: "film")
        backdropImageView.contentMode = .scaleAspectFit
    }
}
