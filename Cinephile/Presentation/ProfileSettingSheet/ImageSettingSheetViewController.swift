//
//  ImageSettingSheetViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/31/25.
//

import UIKit

final class ImageSettingSheetViewController: BaseViewController {

    private var imageSettingSheetView = ImageSettingSheetView()
    var imageContents: UIImage?
    let imageList = ProfileImage.allCases
    
    override func loadView() {
        view = imageSettingSheetView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveImage()
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 이미지 설정"
        imageSettingSheetView.imageCollectionView.delegate = self
        imageSettingSheetView.imageCollectionView.dataSource = self
        imageSettingSheetView.imageCollectionView.register(ImageCollectionViewSheetCell.self, forCellWithReuseIdentifier: ImageCollectionViewSheetCell.id)
    }
    
    override func configureView() {
        imageSettingSheetView.previewImage.image = imageContents
    }
    
    private func saveImage() {
        guard let imageValue = imageSettingSheetView.previewImage.image else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("ImageReceived"),
            object: nil,
            userInfo: [
                "image": imageValue
            ]
        )
    }
}

extension ImageSettingSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSettingSheetView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewSheetCell.id, for: indexPath) as? ImageCollectionViewSheetCell else { return UICollectionViewCell() }
        
        let data = imageList[indexPath.item]
        
        cell.imageSelection.image = data.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = imageList[indexPath.item]
        imageSettingSheetView.previewImage.image = data.image
    }
}
