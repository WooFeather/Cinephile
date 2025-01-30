//
//  ProfileViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private var settingView = SettingView()
    private let settingList = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func loadView() {
        view = settingView
    }
    
    // TODO: reload시점 수정(시트가 내려갈때?)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    override func configureEssential() {
        navigationItem.title = "설정"
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }
    
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if sender.state == .ended {
                let vc = ProfileSettingSheetViewController()
                
                if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
                   let image = UIImage(data: imageData) {
                    vc.imageContents = image
                }
                vc.nicknameContents = UserDefaultsManager.shared.nickname
                
                let nav = UINavigationController(rootViewController: vc)
                present(nav, animated: true)
            }
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
            cell.roundBackgroundView.addGestureRecognizer(tapGesture)
            cell.roundBackgroundView.isUserInteractionEnabled = true
            
            // UserDefaults에 저장된 프로필 이미지 적용
            if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
               let image = UIImage(data: imageData) {
                cell.profileImageView.image = image
            }
            cell.nicknameLabel.text = UserDefaultsManager.shared.nickname
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            // TODO: movieBoxButton에 좋아요 개수 반영
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            let data = settingList[indexPath.row - 1]
            
            cell.titleLabel.text = data
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", button: "확인", isCancelButton: true) {
                // UserDefaults의 데이터 삭제
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let vc = UINavigationController(rootViewController: OnboardingViewController())
                self.changeRootViewController(vc: vc, isSigned: false)
            }
        }
    }
}
