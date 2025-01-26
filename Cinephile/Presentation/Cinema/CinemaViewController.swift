//
//  CinemaViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

//protocol ButtonTappedDelegate {
//    func movieBoxButtonTapped()
//}

final class CinemaViewController: BaseViewController {

    private var cinemaView = CinemaView()
    
    override func loadView() {
        view = cinemaView
    }
    
    override func configureEssential() {
        navigationItem.title = "CINEPHILE"
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped)), animated: true)
        cinemaView.tableView.delegate = self
        cinemaView.tableView.dataSource = self
    }
    
    override func configureView() {
        cinemaView.tableView.separatorStyle = .none
        cinemaView.tableView.isUserInteractionEnabled = false
    }
    
    @objc
    private func searchButtonTapped() {
        print(#function)
    }
    
    @objc
    private func movieBoxButtonTapped(sender: UIButton) {
        print("이건될라나아ㅏ")
    }
}

extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            
//            cell.imageViewTapped = {
//                print("제발돼라아아!!!")
//            }
            
//            cell.buttonTapped = {
//                print("얍얍얍얍 ")
//            }
            
//            cell.delegate = self
            
            cell.movieBoxButton.tag = indexPath.row
            cell.movieBoxButton.addTarget(self, action: #selector(movieBoxButtonTapped), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.id, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .blue
            
            return cell
        } else {
            guard let cell = cinemaView.tableView.dequeueReusableCell(withIdentifier: TodayMovieTableViewCell.id, for: indexPath) as? TodayMovieTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .green
            
            return cell
        }
    }
}

//extension CinemaViewController: ButtonTappedDelegate {
//    func movieBoxButtonTapped() {
//        print("무비박스버튼이 탭이됐다!!!!")
//    }
//}
