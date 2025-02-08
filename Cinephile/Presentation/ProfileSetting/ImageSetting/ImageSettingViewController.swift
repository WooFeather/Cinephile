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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveImage()
    }
    
    override func configureEssential() {
        navigationItem.title = "프로필 이미지 설정"
        imageSettingView.imageCollectionView.delegate = self
        imageSettingView.imageCollectionView.dataSource = self
        imageSettingView.imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
    }
    
    override func configureView() {
        imageSettingView.previewImage.image = imageContents
    }
    
    private func saveImage() {
        guard let imageValue = imageSettingView.previewImage.image else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("ImageReceived"),
            object: nil,
            userInfo: [
                "image": imageValue
            ]
        )
    }
}

extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSettingView.imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let data = imageList[indexPath.item]
        
        cell.imageSelection.image = data.image
        
        // TODO: 이 뷰에 들어왔을 때 profileSettingView의 이미지 셀이 선택된 상태로 표시
//        print("1️⃣", imageContents ?? "")
//        print("2️⃣", cell.imageSelection.image ?? "")
//        print("3️⃣", imageContents == cell.imageSelection.image)
//        
//        if imageContents == cell.imageSelection.image {
//            print("4️⃣", indexPath.item)
//            cell.isSelected = true
//            print("5️⃣", cell.isSelected)
//        } else {
//            cell.isSelected = false
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = imageList[indexPath.item]
        imageSettingView.previewImage.image = data.image
    }
}
