//
//  SearchMovieView.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit
import SnapKit

class SearchMovieView: BaseView{

    let movieSearchBar = UISearchBar()
    let searchTableView = UITableView()

    override func configureHierarchy() {
        addSubview(movieSearchBar)
        addSubview(searchTableView)
    }
    
    override func configureLayout() {
        movieSearchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        movieSearchBar.tintColor = .cinaWhite
        movieSearchBar.barTintColor = .cineBlack
        movieSearchBar.searchTextField.textColor = .cinaWhite
        
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.backgroundColor = .red
    }
}
