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
    private var imageContents: UIImage?
    private var nicknameContents: String?
    
    override func loadView() {
        view = settingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveUserDefaultsValue()
    }
    
    override func configureEssential() {
        navigationItem.title = "설정"
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }
    
    private func saveUserDefaultsValue() {
        // UserDefaults에 저장된 이미지, 닉네임 데이터 담기
        let imageData = UserDefaultsManager.shared.profileImage
        imageContents = UIImage(data: imageData)
        nicknameContents = UserDefaultsManager.shared.nickname
        
        self.settingView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    @objc
    private func backgroundViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let vc = ProfileSettingViewController()
            
            // 기존의 이미지, 닉네임을 sheet로 전달
            let imageData = UserDefaultsManager.shared.profileImage

            if let image = UIImage(data: imageData) {
                vc.viewModel.output.imageDataContents.value = image.pngData() ?? Data()
            }
            vc.viewModel.output.nicknameContents.value = UserDefaultsManager.shared.nickname
            
            let group = DispatchGroup()
            
            // sheet에서 다시 저장한 닉네임 데이터 받기
            group.enter()
            vc.viewModel.reSaveImage = { [weak self] value in
                UserDefaultsManager.shared.profileImage = value
                self?.imageContents = UIImage(data: value)
                group.leave()
            }
            
            // sheet에서 다시 저장한 이미지 데이터 받기
            group.enter()
            vc.viewModel.reSaveNickname = { [weak self] value in
                UserDefaultsManager.shared.nickname = value
                self?.nicknameContents = value
                group.leave()
            }
            
            // 한번에 UI업데이트를 위해 DispatchGroup 사용
            group.notify(queue: .main) { [weak self] in
                self?.settingView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
            
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
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
            
            cell.profileImageView.image = imageContents
            cell.nicknameLabel.text = nicknameContents
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            cell.movieBoxButton.setTitle("\(UserDefaultsManager.shared.likeMovieIdList.count)개의 무비박스 보관중", for: .normal)
            
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
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", button: "확인", isCancelButton: true) { [weak self] in
                // UserDefaults의 데이터 삭제
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let vc = UINavigationController(rootViewController: OnboardingViewController())
                self?.changeRootViewController(vc: vc, isSigned: false)
            }
        }
    }
}
