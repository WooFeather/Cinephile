//
//  CinemaView.swift
//  Cinephile
//
//  Created by 조우현 on 1/26/25.
//

import UIKit
import SnapKit

final class CinemaView: BaseView {
    
    let tableView = UITableView()

    override func configureHierarchy() {
        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
    }
}
