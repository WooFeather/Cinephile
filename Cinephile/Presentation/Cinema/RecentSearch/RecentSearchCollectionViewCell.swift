//
//  RecentSearchCollectionViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/27/25.
//

import UIKit
import SnapKit

final class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "RecentWordsCollectionViewCell"
    let searchTextLabel = UILabel()
    let removeButton = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(searchTextLabel)
        contentView.addSubview(removeButton)
    }
    
    override func configureLayout() {
        searchTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(removeButton.snp.leading)
        }
        
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextLabel.snp.centerY)
            make.trailing.equalTo(contentView).offset(-8)
        }
    }
    
    override func configureView() {
        searchTextLabel.font = .systemFont(ofSize: 15)
        searchTextLabel.textColor = .cineBlack
        
        removeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        removeButton.tintColor = .cineBlack
    }
    
    override func configureCell() {
        backgroundColor = .cineSecondaryGray
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
    
    func configureData(data: String) {
        searchTextLabel.text = data
    }
    
    // 셀의 사이즈를 동적으로 설정하기 위한 메서드
    static func fittingSize(availableHeight: CGFloat, text: String) -> CGSize {
        let cell = RecentSearchCollectionViewCell()
        cell.configureData(data: text)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
