//
//  ImageSettingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class ImageSettingView: BaseView {

    private let cameraImageView = UIImageView()
    let imageSettingButton = ImageButton()
    
    override func configureHierarchy() {
        [imageSettingButton, cameraImageView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageSettingButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(36)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.top.equalTo(imageSettingButton.snp.bottom).offset(-30)
            make.trailing.equalTo(imageSettingButton.snp.trailing)
            make.size.equalTo(25)
        }
    }
    
    override func configureView() {
        imageSettingButton.isUserInteractionEnabled = false
        
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .cineAccent
        cameraImageView.tintColor = .cinaWhite
        DispatchQueue.main.async {
            self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        }
    }
}
