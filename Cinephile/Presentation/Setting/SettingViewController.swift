//
//  ProfileViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private var settingView = SettingView()
    let viewModel = SettingViewModel()
    
    override func loadView() {
        view = settingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.viewWillAppearTrigger.value = ()
    }
    
    override func bindData() {
        viewModel.output.imageDataContents.bind { [weak self] _ in
            self?.settingView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
        viewModel.output.nicknameContents.bind { [weak self] _ in
            self?.settingView.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
        viewModel.output.backgroundViewTapped.lazyBind { [weak self] _ in
            let vc = ProfileSettingViewController()
            
            // 기존의 이미지, 닉네임을 sheet로 전달
            vc.viewModel.output.imageDataContents.value =  self?.viewModel.output.imageDataContents.value ?? Data()
            vc.viewModel.output.nicknameContents.value = self?.viewModel.output.nicknameContents.value ?? ""
            vc.viewModel.reSaveImage = { value in
                self?.viewModel.input.imageReSave.value = value
            }
            vc.viewModel.reSaveNickname = { value in
                self?.viewModel.input.nicknameReSave.value = value
            }
            
            let nav = UINavigationController(rootViewController: vc)
            self?.present(nav, animated: true)
        }
        
        viewModel.output.resignButtonTapped.lazyBind { [weak self] _ in
            self?.showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", button: "확인", isCancelButton: true) { [weak self] in
                // UserDefaults의 데이터 삭제
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let vc = UINavigationController(rootViewController: OnboardingViewController())
                self?.changeRootViewController(vc: vc, isSigned: false)
            }
        }
    }
    
    override func configureEssential() {
        navigationItem.title = "설정"
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
        settingView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }
    
    @objc
    private func backgroundViewTapped() {
        viewModel.input.backgroundViewTapped.value = ()
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
            
            cell.profileImageView.image = UIImage(data: viewModel.output.imageDataContents.value)
            cell.nicknameLabel.text = viewModel.output.nicknameContents.value
            cell.dateLabel.text = UserDefaultsManager.shared.joinDate
            cell.movieBoxButton.setTitle("\(UserDefaultsManager.shared.likeMovieIdList.count)개의 무비박스 보관중", for: .normal)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            let data = viewModel.settingList[indexPath.row - 1]
            
            cell.titleLabel.text = data
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            viewModel.input.resignButtonTapped.value = ()
        }
    }
}
