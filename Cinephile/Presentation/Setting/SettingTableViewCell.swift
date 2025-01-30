//
//  SettingTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell {

    static let id = "SettingTableViewCell"
    
    private let separator = UIView()
    let titleLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separator)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(12)
            make.height.equalTo(20)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .cineSecondaryGray
        
        separator.backgroundColor = .cineBackgroundGray
    }
}
