//
//  PosterTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class PosterTableViewCell: BaseTableViewCell {

    static let id = "PosterTableViewCell"

    private let sectionLabel = UILabel()
    lazy var posterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(posterCollectionView)
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(180)
            make.bottom.equalTo(contentView).offset(-8)
        }
    }
    
    override func configureView() {
        sectionLabel.text = "Poster"
        sectionLabel.font = .boldSystemFont(ofSize: 16)
        
        posterCollectionView.showsHorizontalScrollIndicator = false
        posterCollectionView.backgroundColor = .clear
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        return layout
    }
}
