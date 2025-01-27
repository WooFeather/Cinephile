//
//  TodayMovieTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

final class TodayMovieTableViewCell: BaseTableViewCell {

    static let id = "TodayMovieTableViewCell"
    
    private let sectionLabel = UILabel()
    lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func configureHierarchy() {
        contentView.addSubview(sectionLabel)
        contentView.addSubview(movieCollectionView)
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(12)
            make.height.equalTo(20)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(380)
        }
    }
    
    override func configureView() {
        sectionLabel.text = "오늘의 영화"
        sectionLabel.font = .boldSystemFont(ofSize: 16)
        
        movieCollectionView.backgroundColor = .green
        movieCollectionView.layer.borderWidth = 1
        movieCollectionView.layer.borderColor = UIColor.red.cgColor
    }
    
    // TODO: 수정예정
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 350)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing =  0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
