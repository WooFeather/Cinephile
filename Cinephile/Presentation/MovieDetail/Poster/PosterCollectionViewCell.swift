//
//  PosterCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "PosterCollectionViewCell"
    
    let posterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        posterImageView.backgroundColor = .cineBackgroundGray
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
    }
    
    func configureData(data: Poster) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.image)")
        posterImageView.kf.setImage(with: url)
    }
}
