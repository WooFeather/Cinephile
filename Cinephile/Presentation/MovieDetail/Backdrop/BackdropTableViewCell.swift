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
    // MovieDetailVC에서 currentPage값을 바꿔주기 위해 static으로 선언
    static let pageControl = UIPageControl()

    lazy var backdropCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private let firstDivider = UIView()
    private let secondDivider = UIView()
    let releaseDateButton = InfoButton(icon: UIImage(systemName: "calendar") ?? UIImage())
    let ratingButton = InfoButton(icon: UIImage(systemName: "star.fill") ?? UIImage())
    let genreButton = InfoButton(icon: UIImage(systemName: "film.fill") ?? UIImage())
    
    override func configureHierarchy() {
        contentView.addSubview(backdropCollectionView)
        contentView.addSubview(BackdropTableViewCell.pageControl)
        
        [releaseDateButton, firstDivider, ratingButton, secondDivider, genreButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backdropCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        BackdropTableViewCell.pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(backdropCollectionView.snp.bottom).offset(-12)
            make.centerX.equalTo(backdropCollectionView.snp.centerX)
        }
        
        // stackView로 했을때 각 컴포넌트의 width가 너무 넓게 잡혀서 일단 stackView 미사용
        ratingButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(backdropCollectionView.snp.bottom).offset(12)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView)
        }
        
        firstDivider.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.trailing.equalTo(ratingButton.snp.leading).offset(-2)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        
        secondDivider.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.leading.equalTo(ratingButton.snp.trailing).offset(2)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        
        releaseDateButton.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.trailing.equalTo(firstDivider.snp.leading).offset(-2)
            make.height.equalTo(20)
        }
        
        genreButton.snp.makeConstraints { make in
            make.centerY.equalTo(ratingButton.snp.centerY)
            make.leading.equalTo(secondDivider.snp.trailing).offset(2)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        backdropCollectionView.isPagingEnabled = true
        backdropCollectionView.backgroundColor = .clear
        
        backdropCollectionView.showsHorizontalScrollIndicator = false

        firstDivider.backgroundColor = .cineBackgroundGray
        secondDivider.backgroundColor = .cineBackgroundGray
        
        BackdropTableViewCell.pageControl.backgroundStyle = .prominent
        BackdropTableViewCell.pageControl.hidesForSinglePage = true
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
