//
//  ProfileSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

import Foundation

final class ProfileSettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    var reSaveNickname: ((String) -> Void)?
    var reSaveImage: ((Data) -> Void)?
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
        let imageViewTapped: Observable<Void?> = Observable(nil)
        let nicknameTextFieldEditingChanged: Observable<String?> = Observable(nil)
        let doneButtonTapped: Observable<Void?> = Observable(nil)
        let nicknameTextFieldText: Observable<String?> = Observable(nil)
        let profileImageData: Observable<Data?> = Observable(nil)
        let closeButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let profileImageData: Observable<Data?> = Observable(nil)
        let imageViewTapped: Observable<Void?> = Observable(nil)
        let statusLabelText: Observable<String> = Observable("")
        let nicknameValidation: Observable<Bool> = Observable(false)
        let doneButtonTapped: Observable<Void?> = Observable(nil)
        let closeButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("ProfileSettingViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("ProfileSettingViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        input.viewDidLoadTrigger.lazyBind { _ in
            self.receiveImage()
        }
        
        input.imageViewTapped.lazyBind { _ in
            print("inputImageViewTapped bind")
            self.output.imageViewTapped.value = ()
        }
        
        input.nicknameTextFieldEditingChanged.lazyBind { _ in
            self.validateText()
        }
        
        input.doneButtonTapped.lazyBind { _ in
            self.saveData()
            self.output.doneButtonTapped.value = ()
        }
        
        input.closeButtonTapped.lazyBind { _ in
            if UserDefaultsManager.shared.isSigned {
                self.output.closeButtonTapped.value = ()
            }
        }
    }
    
    private func receiveImage() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(imageReceivedNotification),
            name: NSNotification.Name("ImageReceived"),
            object: nil
        )
    }
    
    @objc
    private func imageReceivedNotification(value: NSNotification) {
        if let imageData = value.userInfo!["imageData"] as? Data {
            output.profileImageData.value = imageData
        }
    }
    
    private func validateText() {
        guard let text = input.nicknameTextFieldEditingChanged.value else { return }
        let trimmingText = text.trimmingCharacters(in: .whitespaces)
        
        // 숫자가 포함되어있는지 확인하는법
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드를 참고해 특수문자도 적용
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            self.output.statusLabelText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            self.output.nicknameValidation.value = false
        } else if spacialRange != nil {
            self.output.statusLabelText.value = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            self.output.nicknameValidation.value = false
        } else if decimalRange != nil {
            self.output.statusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            self.output.nicknameValidation.value = false
        } else {
            self.output.statusLabelText.value = "사용할 수 있는 닉네임이에요"
            self.output.nicknameValidation.value = true
        }
    }
    
    private func saveData() {
        if UserDefaultsManager.shared.isSigned {
            // TODO: isSigned됐을때도 분리 => settingView부분까지 수정해야해서 일단 보류
            reSaveImage?(input.profileImageData.value ?? Data())
            reSaveNickname?(input.nicknameTextFieldText.value ?? "")
        } else {
            UserDefaultsManager.shared.nickname = input.nicknameTextFieldText.value ?? ""
            UserDefaultsManager.shared.joinDate = Date().toJoinString()
            if let imageData = input.profileImageData.value {
                UserDefaultsManager.shared.profileImage = imageData
            }
        }
    }
}
