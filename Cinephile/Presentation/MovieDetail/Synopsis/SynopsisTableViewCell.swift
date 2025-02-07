//
//  SynopsisTableViewCell.swift
//  Cinephile
//
//  Created by 조우현 on 1/30/25.
//

import UIKit
import SnapKit

final class SynopsisTableViewCell: BaseTableViewCell {

    static let id = "SynopsisTableViewCell"

    private let sectionLabel = UILabel()
    private let extensionButton = UIButton()
    private var isExtended = false
    let synopsisLabel = UILabel()
    
    override func configureHierarchy() {
        [sectionLabel, extensionButton, synopsisLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(12)
            make.height.equalTo(20)
        }
        
        extensionButton.snp.makeConstraints { make in
            make.centerY.equalTo(sectionLabel.snp.centerY)
            make.trailing.equalTo(contentView).offset(-12)
            make.height.equalTo(20)
        }
        
        synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        sectionLabel.text = "Synopsis"
        sectionLabel.font = .boldSystemFont(ofSize: 16)
        
        extensionButton.setTitle("More", for: .normal)
        extensionButton.addTarget(self, action: #selector(extensionButtonTapped), for: .touchUpInside)
        extensionButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        extensionButton.setTitleColor(.cineAccent, for: .normal)
        
        synopsisLabel.numberOfLines = 3
        synopsisLabel.font = .systemFont(ofSize: 15)
        synopsisLabel.textColor = .cineSecondaryGray
    }
    
    @objc
    private func extensionButtonTapped() {
        isExtended.toggle()
        extensionButton.setTitle(isExtended ? "Hide" : "More", for: .normal)
        synopsisLabel.numberOfLines = isExtended ? 0 : 3
        
        invalidateIntrinsicContentSize()
    }
}
