//
//  BackdropTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class BackdropTableViewCell: BaseTableViewCell {

    static let id = "BackdropTableViewCell"

    lazy var backdropCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let infoStackView = UIStackView()
    let releaseDateLabel = UILabel()
    let ratingLabel = UILabel()
    let genreLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(backdropCollectionView)
        contentView.addSubview(infoStackView)
        [releaseDateLabel, ratingLabel, genreLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        backdropCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(backdropCollectionView.snp.bottom).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        backdropCollectionView.isPagingEnabled = true
        backdropCollectionView.backgroundColor = .cineBackgroundGray
        
        // TODO: 인디케이터 모양 바꾼 이후에 활성화 예정
        // backdropCollectionView.showsHorizontalScrollIndicator = false
        
        infoStackView.spacing = 10
        
        // TODO: 커스텀 버튼으로 이 세개의 컴포넌트 분리(디바이더도 고민)
        releaseDateLabel.text = "8888-88-88"
        releaseDateLabel.font = .systemFont(ofSize: 14)
        
        ratingLabel.text = "8.0"
        ratingLabel.font = .systemFont(ofSize: 14)
        
        genreLabel.text = "테스트, 테스트, 테스트"
        genreLabel.font = .systemFont(ofSize: 14)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: deviceWidth, height: 250)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing =  0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}
