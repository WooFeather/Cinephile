//
//  ImageSettingViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

final class ImageSettingViewController: BaseViewController {
    
    private var imageSettingView = ImageSettingView()
    let viewModel = ImageSettingViewModel()
    var imageContents: UIImage?
    let imageList = ProfileImage.allCases
    
    // MARK: - LifeCycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.input.profileImageData.value = imageSettingView.previewImage.image?.pngData()
    }
    
    // MARK: - Functions
    override func loadView() {
        view = imageSettingView
    }
    
    override func configureEssential() {
        imageSettingView.imageCollectionView.delegate = self
        imageSettingView.imageCollectionView.dataSource = self
        imageSettingView.imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
    }
    
    override func configureView() {
        navigationItem.title = "프로필 이미지 설정"
    }
    
    override func bindData() {
        viewModel.output.profileImageData.bind { [weak self] data in
            guard let data = data else { return }
            self?.imageSettingView.previewImage.image = UIImage(data: data)
        }
        
        viewModel.output.cellSelected.lazyBind { [weak self] data in
            self?.imageSettingView.previewImage.image = data?.image
        }
    }
}

// MARK: - Extension
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
        viewModel.input.cellSelected.value = data
    }
}
