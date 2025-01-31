//
//  BackdropCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

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
        backdropImageView.backgroundColor = .cineBackgroundGray
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
    }
    
    func configureData(data: Backdrop) {
        // original로 하면 불러오는데 너무 오래걸려서 이미지 크기를 일단 w500으로 조정
        if let image = data.image {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
            backdropImageView.kf.setImage(with: url)
        } else {
            backdropImageView.image = UIImage(systemName: "questionmark")
            backdropImageView.tintColor = .cineAccent
        }
    }
}
