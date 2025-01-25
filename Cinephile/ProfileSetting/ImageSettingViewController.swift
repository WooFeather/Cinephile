//
//  ImageSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class ImageSettingViewController: BaseViewController {
    private var imageSettingView = ImageSettingView()
    var imageContents: UIImage?
    
    override func loadView() {
        view = imageSettingView
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 이미지 설정"
    }
    
    override func configureView() {
        super.configureView()
        self.imageSettingView.previewImage.setImage(imageContents, for: .normal)
    }
}
