//
//  ImageSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ImageSettingViewController: BaseViewController {
    private var imageSettingView = ImageSettingView()
    var imageContents: UIImage?
    let imageList = ProfileImage.allCases
    
    override func loadView() {
        view = imageSettingView
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 이미지 설정"
        imageSettingView.imageCollectionView.delegate = self
        imageSettingView.imageCollectionView.dataSource = self
    }
    
    override func configureView() {
        super.configureView()
        imageSettingView.previewImage.setImage(imageContents, for: .normal)
    }
}

extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSettingView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let data = imageList[indexPath.item]
        
        cell.imageButton.setImage(data.image, for: .normal)
        
        return cell
    }
}
