//
//  SearchTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    static let id = "SearchTableViewCell"
    
    private let genreStackView = UIStackView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let likeButton = UIButton()
    let firstGenreLabel = GenreLabel()
    let secondGenreLabel = GenreLabel()
    
    override func configureHierarchy() {
        [posterImageView, titleLabel, releaseDateLabel, genreStackView, likeButton].forEach {
            contentView.addSubview($0)
        }
        [firstGenreLabel, secondGenreLabel].forEach {
            genreStackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.height.greaterThanOrEqualTo(20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.height.equalTo(16)
        }
        
        genreStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(24)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(genreStackView.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    override func configureView() {
        posterImageView.backgroundColor = .cineBackgroundGray
        DispatchQueue.main.async {
            self.posterImageView.layer.cornerRadius = self.posterImageView.frame.height / 14
        }
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        // TODO: 교체예정
        titleLabel.text = "테스트테스트테스트테스트"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        
        // TODO: 교체예정
        releaseDateLabel.text = "8888. 88. 88"
        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .cinePrimaryGray
        
        genreStackView.spacing = 4
        
        firstGenreLabel.text = "테스트지롱"
        secondGenreLabel.text = "테스트"
        
        // TODO: 좋아요기능 UI 구현
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
