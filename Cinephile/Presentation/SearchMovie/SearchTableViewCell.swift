//
//  SearchTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchTableViewCell: BaseTableViewCell {
    
    static let id = "SearchTableViewCell"
    
    private let genre: [Int: String] = [
        28: "액션",
        16: "애니메이션",
        80: "범죄",
        18: "드라마",
        14: "판타지",
        27: "공포",
        9648: "미스터리",
        878: "SF",
        53: "스릴러",
        37: "서부",
        12: "모험",
        35: "코미디",
        99: "다큐멘터리",
        10751: "가족",
        36: "역사",
        10402: "음악",
        10749: "로맨스",
        10770: "TV 영화",
        10752: "전쟁"
    ]
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
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        
        
        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .cinePrimaryGray
        
        genreStackView.spacing = 4
        
        firstGenreLabel.text = "테스트지롱"
        secondGenreLabel.text = "테스트"
    }
    
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configureData(data: MovieDetail) {
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data.posterImage)")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = data.title
        releaseDateLabel.text = data.releaseDate.toDate()?.toReleaseString()
        
        // 이렇게 하면 검색 결과가 없거나, genre가 1개일 경우에 fatalError
//        firstGenreLabel.text = genre[data.genreList[0]]
//        secondGenreLabel.text = genre[data.genreList[1]]
        
        // 어떻게 장르에 대응할 수 있을까
//        if !data.genreList.isEmpty {
//            for i in 0...1 {
//                let genreLabel = GenreLabel()
//                genreLabel.text = genre[data.genreList[i]]
//            }
//        }
        
        // TODO: 좋아요기능 UI 구현
        // 조건이 data의 like가 아니라, 해당 영화의 id가 좋아요리스트에 등록되어있는가가 기준이 될듯
//        let name = item.like ? "heart.fill" : "heart"
//        let btn = UIImage(systemName: name)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
