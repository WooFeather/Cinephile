//
//  CinemaView.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

class CinemaView: BaseView {
    
    lazy var tableView = UITableView()

    override func configureHierarchy() {
        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .red
        tableView.isScrollEnabled = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        tableView.register(RecentSearchTableViewCell.self, forCellReuseIdentifier: RecentSearchTableViewCell.id)
        tableView.register(TodayMovieTableViewCell.self, forCellReuseIdentifier: TodayMovieTableViewCell.id)
    }
}
