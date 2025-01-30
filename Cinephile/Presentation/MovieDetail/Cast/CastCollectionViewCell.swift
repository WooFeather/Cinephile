//
//  CastCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class CastCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "CastCollectionViewCell"
    
    let imageView = UIImageView()
    let koreanNameLabel = UILabel()
    let englishNameLabel = UILabel()
    
    override func configureHierarchy() {
        [imageView, koreanNameLabel, englishNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView)
            make.width.equalTo(60)
        }
        
        koreanNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.height.equalTo(20)
        }
        
        englishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(koreanNameLabel.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.height.equalTo(16)
        }
    }
    
    override func configureView() {
        imageView.backgroundColor = .brown
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
        imageView.clipsToBounds = true
        
        // TODO: ConfigureData에서 실제 데이터로 교체 예정
        koreanNameLabel.text = "테스트"
        koreanNameLabel.font = .boldSystemFont(ofSize: 15)
        
        englishNameLabel.text = "This is Test-Name"
        englishNameLabel.font = .systemFont(ofSize: 14)
        englishNameLabel.textColor = .cinePrimaryGray
    }
}
