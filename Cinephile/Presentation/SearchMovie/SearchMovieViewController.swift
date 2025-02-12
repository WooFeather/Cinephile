//
//  SearchMovieViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

final class SearchMovieViewController: BaseViewController {

    private var searchMovieView = SearchMovieView()
    let viewModel = SearchMovieViewModel()
    
    override func loadView() {
        view = searchMovieView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.viewWillAppearTrigger.value = ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.input.viewDidAppearTrigger.value = ()
    }
    
    override func bindData() {
        viewModel.output.searchText.bind { text in
            self.searchMovieView.movieSearchBar.text = text
        }
        
        viewModel.output.viewWillAppearTrigger.bind { _ in
            self.searchMovieView.searchTableView.reloadData()
        }
        
        viewModel.output.viewDidAppearTrigger.lazyBind { _ in
            self.searchMovieView.movieSearchBar.becomeFirstResponder()
        }
        
        viewModel.output.searchButtonTapped.lazyBind { _ in
            print("====2====")
            self.searchMovieView.searchTableView.reloadData()
            if self.viewModel.output.page.value == 1 && self.viewModel.output.searchList.value.count != 0 {
                self.searchMovieView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            self.searchMovieView.searchTableView.isHidden = self.viewModel.output.tableViewHidden.value
            self.searchMovieView.emptyLabel.isHidden = self.viewModel.output.emptyLabelHidden.value
            self.searchMovieView.movieSearchBar.resignFirstResponder()
        }
        
        viewModel.output.likeButtonTapped.lazyBind { index in
            self.searchMovieView.searchTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        viewModel.output.movieData.lazyBind { data in
            guard let data = data else { return }
            let vc = MovieDetailViewController()
            // TODO: 추후 DetailView 리팩토링시 VM로 바로 전달
            vc.idContents = data.id
            vc.titleContents = data.title
            vc.synopsisContents = data.overview
            vc.releaseDateContents = data.releaseDate
            vc.ratingContents = data.rating
            
            if data.genreList.count == 1 {
                vc.firstGenreContents = SearchTableViewCell.genre[data.genreList[0]]
            } else if data.genreList.count >= 2 {
                vc.firstGenreContents = SearchTableViewCell.genre[data.genreList[0]]
                vc.secondGenreContents = SearchTableViewCell.genre[data.genreList[1]]
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func configureEssential() {
        navigationItem.title = "영화 검색"
        searchMovieView.searchTableView.delegate = self
        searchMovieView.searchTableView.dataSource = self
        searchMovieView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        searchMovieView.searchTableView.prefetchDataSource = self
        
        searchMovieView.movieSearchBar.delegate = self
    }
    
    override func configureView() {
        searchMovieView.searchTableView.isHidden = true
        searchMovieView.emptyLabel.isHidden = true
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        viewModel.input.likeButtonTapped.value = sender.tag
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.searchList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let data = viewModel.output.searchList.value[indexPath.row]
        
        cell.configureData(data: data)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.movieTapped.value = indexPath.item
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
}

extension SearchMovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("🔗indexPath \(indexPaths)")
        
        for row in indexPaths {
            if viewModel.output.searchList.value.count - 3 == row.row {
                if viewModel.output.searchList.value.count < viewModel.output.maxNum.value {
                    viewModel.output.page.value += 1
                    viewModel.input.pagination.value = viewModel.output.queryText.value
                } else {
                    print("❗️마지막 페이지")
                }
            }
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchButtonTapped.value = searchBar.text
    }
}
