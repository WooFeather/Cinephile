//
//  CastTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class CastTableViewCell: BaseTableViewCell {

    static let id = "CastTableViewCell"

    private let sectionLabel = UILabel()
    lazy var castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(castCollectionView)
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(12)
            make.height.equalTo(20)
        }
        
        castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(130)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        sectionLabel.text = "Cast"
        sectionLabel.font = .boldSystemFont(ofSize: 16)
        
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.backgroundColor = .clear
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 200, height: 60)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing =  10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        return layout
    }
}
