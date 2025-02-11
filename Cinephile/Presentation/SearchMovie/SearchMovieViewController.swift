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
//    private var searchList: [MovieDetail] = []
//    private var page = 1
//    private var maxNum = 0
//    private lazy var queryText = searchMovieView.movieSearchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
//    var searchTextContents: String?
    
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
            print("====2====", self.viewModel.output.searchList.value)
            self.searchMovieView.searchTableView.reloadData()
            if self.viewModel.output.page.value == 1 && self.viewModel.output.searchList.value.count != 0 {
                self.searchMovieView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            self.searchMovieView.searchTableView.isHidden = self.viewModel.output.tableViewHidden.value
            self.searchMovieView.emptyLabel.isHidden = self.viewModel.output.emptyLabelHidden.value
            self.searchMovieView.movieSearchBar.resignFirstResponder()
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
    
//    func callRequest(query: String) {
//        NetworkManager.shared.callTMDBAPI(api: .search(query: query, page: page), type: Movie.self) { value in
//            if self.page == 1 {
//                self.searchList = value.results
//            } else {
//                self.searchList.append(contentsOf: value.results)
//            }
//            
//            if self.searchList.isEmpty {
//                self.searchMovieView.searchTableView.isHidden = true
//                self.searchMovieView.emptyLabel.isHidden = false
//            } else {
//                self.searchMovieView.searchTableView.isHidden = false
//                self.searchMovieView.emptyLabel.isHidden = true
//            }
//            
//            self.maxNum = value.totalResults
//            self.searchMovieView.searchTableView.reloadData()
//            
//            if self.page == 1 && self.searchList.count != 0 {
//                self.searchMovieView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//            }
//        } failHandler: {
//            print("❌ 네트워킹 실패")
//        }
//    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        let item = viewModel.output.searchList.value[sender.tag]
        if LikeMovie.likeMovieIdList.contains(item.id) {
            if let index = LikeMovie.likeMovieIdList.firstIndex(of: item.id) {
                LikeMovie.likeMovieIdList.remove(at: index)
                UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
                UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
            }
        } else {
            LikeMovie.likeMovieIdList.append(item.id)
            UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
            UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
        }
        
        print(LikeMovie.likeMovieIdList)
        print(LikeMovie.likeMovieIdList.count)
        
        searchMovieView.searchTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
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
        let data = viewModel.output.searchList.value[indexPath.row]
        
        let vc = MovieDetailViewController()
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
        navigationController?.pushViewController(vc, animated: true)
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
                    viewModel.input.searchButtonTapped.value = viewModel.output.queryText.value
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
        
//        guard let searchText = searchBar.text else { return }
//        
//        queryText = searchText.trimmingCharacters(in: .whitespaces)
        
        //viewModel.output.page.value = 1
//        callRequest(query: queryText)
        
//        NotificationCenter.default.post(
//            name: NSNotification.Name("SearchTextReceived"),
//            object: nil,
//            userInfo: [
//                "searchText": queryText
//            ]
//        )
        
//        searchBar.resignFirstResponder()
    }
}
