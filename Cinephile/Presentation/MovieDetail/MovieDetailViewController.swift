//
//  MovieDetailViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/29/25.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    private var movieDetailView = MovieDetailView()
    var titleContents: String?
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func configureEssential() {
        navigationItem.title = titleContents
        // TODO: 좋아요 기능 구현
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeButtonTapped)), animated: true)
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        // TODO: 좋아요버튼 기능구현
        print(#function)
    }
}
