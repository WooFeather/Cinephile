//
//  RecentSearchTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit

final class RecentSearchTableViewCell: BaseTableViewCell {
    
    static let id = "RecentSearchTableViewCell"
    
    private let sectionLabel = UILabel()
    lazy var searchWordsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    let emptyLabel = UILabel()
    let clearButton = UIButton()
    
//    override func configureHierarchy() {
//
//    }
//    
//    override func configureLayout() {
//        <#code#>
//    }
//    
//    override func configureView() {
//        <#code#>
//    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 35)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing =  0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
}
