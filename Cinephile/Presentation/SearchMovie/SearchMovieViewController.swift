//
//  SearchMovieViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/28/25.
//

import UIKit

final class SearchMovieViewController: BaseViewController {

    private var searchMovieView = SearchMovieView()
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
        
        searchMovieView.movieSearchBar.delegate = self
    }
    
    override func configureView() {
        searchMovieView.searchTableView.isHidden = true
        searchMovieView.emptyLabel.isHidden = true
        searchMovieView.movieSearchBar.text = searchTextContents
    }
    
    private func callRequest() {
        searchMovieView.searchTableView.isHidden = false
        
        // TODO: 검색결과가 없을 경우 tableView hidden true, emptyLabel hidden false
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 셀 선택시 값 전달과 함께 영화 상세뷰로 push
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
}

// TODO: movieSearchBar 검색버튼 눌렀을 때 callRequest함수 실행
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        callRequest()
    }
}
