//
//  ImageSettingView.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit
import SnapKit

final class ImageSettingView: BaseView {

    private let cameraImageView = UIImageView()
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    var previewImage = ProfileImageView()
    
    override func configureHierarchy() {
        [previewImage, cameraImageView, imageCollectionView].forEach {
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
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom).offset(56)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    override func configureView() {
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .cineAccent
        cameraImageView.tintColor = .cinaWhite
        DispatchQueue.main.async {
            self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        }
        
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
        imageCollectionView.isScrollEnabled = false
        imageCollectionView.backgroundColor = .clear
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 20
        let cellSpacing: CGFloat = 20
        
        let layout = UICollectionViewFlowLayout()
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (sectionInset * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 4, height: (cellWidth / 4))
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        return layout
    }
}
