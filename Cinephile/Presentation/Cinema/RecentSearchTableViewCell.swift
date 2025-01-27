//
//  RecentSearchTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

final class RecentSearchTableViewCell: BaseTableViewCell {
    
    static let id = "RecentSearchTableViewCell"
    
    private let sectionLabel = UILabel()
    lazy var searchWordsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    let emptyLabel = UILabel()
    let clearButton = UIButton()
    
    override func configureHierarchy() {
        [sectionLabel, clearButton, searchWordsCollectionView, emptyLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(12)
            make.height.equalTo(20)
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(sectionLabel.snp.centerY)
            make.trailing.equalTo(contentView).offset(-12)
            make.height.equalTo(20)
        }
        
        searchWordsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(44)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(searchWordsCollectionView.snp.center)
            make.height.equalTo(16)
        }
    }
    
    override func configureView() {
        sectionLabel.text = "최근검색어"
        sectionLabel.font = .boldSystemFont(ofSize: 16)
        
        clearButton.setTitle("전체 삭제", for: .normal)
        clearButton.setTitleColor(.cineAccent, for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        searchWordsCollectionView.backgroundColor = .clear
        
        emptyLabel.text = "최근 검색어 내역이 없습니다."
        emptyLabel.font = .boldSystemFont(ofSize: 12)
        emptyLabel.textColor = .cinePrimaryGray
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing =  0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        return layout
    }
}
