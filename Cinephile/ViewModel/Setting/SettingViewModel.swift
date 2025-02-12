//
//  SettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/12/25.
//

import Foundation

final class SettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    let settingList = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void?> = Observable(nil)
        let backgroundViewTapped: Observable<Void?> = Observable(nil)
        let resignButtonTapped: Observable<Void?> = Observable(nil)
        let imageReSave: Observable<Data> = Observable(Data())
        let nicknameReSave: Observable<String> = Observable("")
    }
    
    struct Output {
        let imageDataContents: Observable<Data> = Observable(Data())
        let nicknameContents: Observable<String> = Observable("")
        let backgroundViewTapped: Observable<Void?> = Observable(nil)
        let resignButtonTapped: Observable<Void?> = Observable(nil)
        let searchText: Observable<String> = Observable("")
        let movieData: Observable<MovieDetail?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("SettingViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("SettingViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        input.viewWillAppearTrigger.lazyBind { [weak self] _ in
            self?.saveUserDefaultsValue()
        }
        
        input.backgroundViewTapped.bind { [weak self] _ in
            self?.profileDataTransfer()
        }
        
        input.resignButtonTapped.bind { [weak self] _ in
            self?.output.resignButtonTapped.value = ()
        }
        
        input.imageReSave.lazyBind { [weak self] data in
            self?.reSaveImage(data: data)
        }
        
        input.nicknameReSave.lazyBind { text in
            self.reSaveNickname(text: text)
        }
    }
    
    private func saveUserDefaultsValue() {
        // UserDefaults에 저장된 이미지, 닉네임 데이터 담기
        output.imageDataContents.value = UserDefaultsManager.shared.profileImage
        output.nicknameContents.value = UserDefaultsManager.shared.nickname
    }
    
    private func profileDataTransfer() {
        output.imageDataContents.value = UserDefaultsManager.shared.profileImage
        output.nicknameContents.value = UserDefaultsManager.shared.nickname
        self.output.backgroundViewTapped.value = ()
    }
    
    private func reSaveImage(data: Data) {
        UserDefaultsManager.shared.profileImage = data
        output.imageDataContents.value = data
    }
    
    private func reSaveNickname(text: String) {
        UserDefaultsManager.shared.nickname = text
        output.nicknameContents.value = text
    }
}
