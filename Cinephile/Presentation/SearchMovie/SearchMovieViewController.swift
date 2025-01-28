//
//  SearchMovieViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

final class SearchMovieViewController: BaseViewController {

    private var searchMovieView = SearchMovieView()
    
    override func loadView() {
        view = searchMovieView
    }
    
    override func configureEssential() {
        navigationItem.title = "영화 검색"
        searchMovieView.searchTableView.delegate = self
        searchMovieView.searchTableView.dataSource = self
        searchMovieView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
