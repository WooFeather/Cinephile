//
//  SearchMovieView.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit
import SnapKit

final class SearchMovieView: BaseView{

    let movieSearchBar = UISearchBar()
    let searchTableView = UITableView()
    let emptyLabel = UILabel()

    override func configureHierarchy() {
        [movieSearchBar, searchTableView, emptyLabel].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        movieSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(12)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(searchTableView.snp.centerX)
            make.centerY.equalTo(searchTableView.snp.centerY).offset(-100)
            make.height.equalTo(16)
        }
    }
    
    override func configureView() {
        movieSearchBar.tintColor = .cinaWhite
        movieSearchBar.barTintColor = .cineBlack
        movieSearchBar.searchTextField.textColor = .cinaWhite
        movieSearchBar.placeholder = "영화를 검색해보세요."
        
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.backgroundColor = .clear
        
        emptyLabel.text = "원하는 검색결과를 찾지 못했습니다"
        emptyLabel.font = .boldSystemFont(ofSize: 12)
        emptyLabel.textColor = .cinePrimaryGray
    }
}
