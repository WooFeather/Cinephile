//
//  ProfileSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

import UIKit

final class ProfileSettingViewModel {
    private var isNicknameValidate = false
    private var isButtonValidate = false
    private var mbtiMbtiButtonArray: [UIButton] = []
    var reSaveNickname: ((String) -> Void)?
    var reSaveImage: ((UIImage) -> Void)?
    
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    let inputImageViewTapped: Observable<Void?> = Observable(nil)
    let inputNicknameTextFieldEditingChanged: Observable<String?> = Observable(nil)
    let inputDoneButtonTapped: Observable<Void?> = Observable(nil)
    let inputNicknameTextFieldText: Observable<String?> = Observable(nil)
    let inputProfileImage: Observable<UIImage?> = Observable(nil)
    let inputCloseButtonTapped: Observable<Void?> = Observable(nil)
    
    // 전체가 선택되었는지 확인을 위한 버튼 input
    let inputEButton: Observable<UIButton> = Observable(UIButton())
    let inputIButton: Observable<UIButton> = Observable(UIButton())
    let inputSButton: Observable<UIButton> = Observable(UIButton())
    let inputNButton: Observable<UIButton> = Observable(UIButton())
    let inputTButton: Observable<UIButton> = Observable(UIButton())
    let inputFButton: Observable<UIButton> = Observable(UIButton())
    let inputJButton: Observable<UIButton> = Observable(UIButton())
    let inputPButton: Observable<UIButton> = Observable(UIButton())
    
    // 토글기능을 위한 버튼 input
    let inputMbtiEIButtonTapped: Observable<UIButton> = Observable(UIButton())
    let inputMbtiSNButtonTapped: Observable<UIButton> = Observable(UIButton())
    let inputMbtiTFButtonTapped: Observable<UIButton> = Observable(UIButton())
    let inputMbtiJPButtonTapped: Observable<UIButton> = Observable(UIButton())
    
    let outputProfileImage: Observable<UIImage?> = Observable(nil)
    let outputImageViewTapped: Observable<Void?> = Observable(nil)
    let outputStatusLabelText: Observable<String> = Observable("") // 상태레이블에 표시될 텍스트
    let outputStatusLabelTextColor: Observable<Bool> = Observable(false) // 상태레이블 텍스트컬러
    let outputDoneButtonEnabled: Observable<Bool> = Observable(false) // isNicknameValidate, isButtonValidate 두 조건이 모두 만족됐을때의 값
    let outputDoneButtonTapped: Observable<Void?> = Observable(nil)
    let outputCloseButtonTapped: Observable<Void?> = Observable(nil)
    
    // MARK: - Initializer
    init() {
        print("ProfileSettingViewModel Init")
        
        inputViewDidLoadTrigger.lazyBind { _ in
            self.receiveImage()
        }
        
        inputImageViewTapped.lazyBind { _ in
            print("inputImageViewTapped bind")
            self.outputImageViewTapped.value = ()
        }
        
        inputNicknameTextFieldEditingChanged.lazyBind { _ in
            self.validateText()
            self.outputDoneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        inputMbtiEIButtonTapped.bind { button in
            print("inputMbtiEIButtonTapped bind")
            self.mbtiMbtiButtonArray = [self.inputEButton.value, self.inputIButton.value]
            self.toggleButton(button, array: self.mbtiMbtiButtonArray)
            self.validateButton()
            self.outputDoneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        inputMbtiSNButtonTapped.bind { button in
            print("inputMbtiSNButtonTapped bind")
            self.mbtiMbtiButtonArray = [self.inputNButton.value, self.inputSButton.value]
            self.toggleButton(button, array: self.mbtiMbtiButtonArray)
            self.validateButton()
            self.outputDoneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        inputMbtiTFButtonTapped.bind { button in
            print("inputMbtiSNButtonTapped bind")
            self.mbtiMbtiButtonArray = [self.inputTButton.value, self.inputFButton.value]
            self.toggleButton(button, array: self.mbtiMbtiButtonArray)
            self.validateButton()
            self.outputDoneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        inputMbtiJPButtonTapped.bind { button in
            print("inputMbtiSNButtonTapped bind")
            self.mbtiMbtiButtonArray = [self.inputJButton.value, self.inputPButton.value]
            self.toggleButton(button, array: self.mbtiMbtiButtonArray)
            self.validateButton()
            self.outputDoneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        inputDoneButtonTapped.lazyBind { _ in
            self.saveData()
            self.outputDoneButtonTapped.value = ()
        }
        
        inputCloseButtonTapped.lazyBind { _ in
            if UserDefaultsManager.shared.isSigned {
                self.outputCloseButtonTapped.value = ()
            }
        }
    }
    
    deinit {
        print("ProfileSettingViewModel Deinit")
    }
    
    // MARK: - Functions
    
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
        if let image = value.userInfo!["image"] as? UIImage {
            outputProfileImage.value = image
        }
    }
    
    private func validateText() {
        guard let text = inputNicknameTextFieldEditingChanged.value else { return }
        let trimmingText = text.trimmingCharacters(in: .whitespaces)
        
        // 숫자가 포함되어있는지 확인하는법
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = trimmingText.rangeOfCharacter(from: decimalCharacters)
        // 위의 코드를 참고해 특수문자도 적용
        let spacialRange = trimmingText.rangeOfCharacter(from: ["@", "#", "$", "%"])
        
        if trimmingText.count < 2 || trimmingText.count > 10 {
            self.outputStatusLabelText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            self.outputStatusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else if spacialRange != nil {
            self.outputStatusLabelText.value = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            self.outputStatusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else if decimalRange != nil {
            self.outputStatusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            self.outputStatusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else {
            self.outputStatusLabelText.value = "사용할 수 있는 닉네임이에요"
            self.outputStatusLabelTextColor.value = true
            self.isNicknameValidate = true
        }
    }
    
    private func toggleButton(_ sender: UIButton, array: [UIButton]) {
        print(#function)
        for i in array {
            // 조건1: 하나의 버튼이 true이면 다른 버튼은 false여야 함
            // 조건2: 이미 true인 버튼을 탭하면 false로 바뀌어야 함
            if i == sender {
                if !i.isSelected {
                    i.isSelected = true
                } else {
                    i.isSelected = false
                }
            } else {
                i.isSelected = false
            }
        }
    }
    
    // 여기에 모든 버튼의 조건을 검증하기 위해 한 개의 버튼들을 전부 input으로 받음...
    // 이 조건이 아니었다면 toggle 확인을 위한 TFButtonTapped 등의 버튼 두 개 묶음의 input을 받았을듯
    private func validateButton() {
        print(#function)
        if (inputEButton.value.isSelected || inputIButton.value.isSelected) &&
            (inputSButton.value.isSelected || inputNButton.value.isSelected) &&
            (inputTButton.value.isSelected || inputFButton.value.isSelected) &&
            (inputJButton.value.isSelected || inputPButton.value.isSelected) {
            isButtonValidate = true
        } else {
            isButtonValidate = false
        }
    }
    
    private func isDoneButtonEnabled() -> Bool {
        if isNicknameValidate && isButtonValidate {
            return true
        } else {
            return false
        }
    }
    
    private func saveData() {
        if UserDefaultsManager.shared.isSigned {
            // TODO: isSigned됐을때도 분리 => settingView부분까지 수정해야해서 일단 보류
            reSaveImage?(inputProfileImage.value ?? UIImage())
            reSaveNickname?(inputNicknameTextFieldText.value ?? "")
        } else {
            UserDefaultsManager.shared.nickname = inputNicknameTextFieldText.value ?? ""
            UserDefaultsManager.shared.joinDate = Date().toJoinString()
            if let imageData = inputProfileImage.value?.pngData() {
                UserDefaultsManager.shared.profileImage = imageData
            }
        }
    }
}
