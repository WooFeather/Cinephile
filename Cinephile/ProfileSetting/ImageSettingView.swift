//
//  ImageSettingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit
import SnapKit

class ImageSettingView: BaseView {

    private let cameraImageView = UIImageView()
    let previewImage = ImageButton()
    
    override func configureHierarchy() {
        [previewImage, cameraImageView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        previewImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(36)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom).offset(-30)
            make.trailing.equalTo(previewImage.snp.trailing)
            make.size.equalTo(25)
        }
    }
    
    override func configureView() {
        previewImage.isUserInteractionEnabled = false
        
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .cineAccent
        cameraImageView.tintColor = .cinaWhite
        DispatchQueue.main.async {
            self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        }
    }
}
