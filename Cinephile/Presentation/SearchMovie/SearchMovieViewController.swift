//
//  SearchMovieViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

final class SearchMovieViewController: BaseViewController {

    private var searchMovieView = SearchMovieView()
    private var searchList: [MovieDetail] = []
    private var page = 1
    private var maxNum = 0
    private lazy var queryText = searchMovieView.movieSearchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
    var searchTextContents: String?
    
    override func loadView() {
        view = searchMovieView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchMovieView.movieSearchBar.becomeFirstResponder()
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
        searchMovieView.movieSearchBar.text = searchTextContents
    }
    
    func callRequest(query: String) {
        NetworkManager.shared.callTMDBAPI(api: .search(query: query, page: page), type: Movie.self) { value in
            if self.page == 1 {
                self.searchList = value.results
            } else {
                self.searchList.append(contentsOf: value.results)
            }
            
            if self.searchList.isEmpty {
                self.searchMovieView.searchTableView.isHidden = true
                self.searchMovieView.emptyLabel.isHidden = false
            } else {
                self.searchMovieView.searchTableView.isHidden = false
                self.searchMovieView.emptyLabel.isHidden = true
            }
            
            self.maxNum = value.totalResults
            self.searchMovieView.searchTableView.reloadData()
            
            if self.page == 1 && self.searchList.count != 0 {
                self.searchMovieView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        } failHandler: {
            print("❌ 네트워킹 실패")
        }

    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        // TODO: 좋아요버튼 기능구현
        // movieList[sender.tag].like.toggle()
        // movieList의 sender의 tag의 id를 가져와서 해당 id를 좋아요리스트에 등록
        print(sender.tag)
        searchMovieView.searchTableView.reloadData()
    }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let data = searchList[indexPath.row]
        
        cell.configureData(data: data)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = searchList[indexPath.row]
        
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
            if searchList.count - 3 == row.row {
                if searchList.count < maxNum {
                    page += 1
                    callRequest(query: queryText)
                } else {
                    print("❗️마지막 페이지")
                }
            }
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        queryText = searchText.trimmingCharacters(in: .whitespaces)
        
        page = 1
        callRequest(query: queryText)
        
        dump(searchList)
        
        NotificationCenter.default.post(
            name: NSNotification.Name("SearchTextReceived"),
            object: nil,
            userInfo: [
                "searchText": queryText
            ]
        )
        
        searchBar.resignFirstResponder()
    }
}
