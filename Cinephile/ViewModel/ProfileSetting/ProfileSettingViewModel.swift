//
//  ProfileSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

// MARK: - UIKit을 import하지 않고 분리하는 시도를 MVVMPractice라는 프로젝트에서 했는데 결국 실패 => MBTI 버튼의 액션을 어떻게 분리해야 할지 모르겠다

import UIKit

final class ProfileSettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    private var isNicknameValidate = false
    private var isButtonValidate = false
    private var mbtiMbtiButtonArray: [UIButton] = []
    var reSaveNickname: ((String) -> Void)?
    var reSaveImage: ((Data) -> Void)?
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
        let imageViewTapped: Observable<Void?> = Observable(nil)
        let nicknameTextFieldEditingChanged: Observable<String?> = Observable(nil)
        let doneButtonTapped: Observable<Void?> = Observable(nil)
        let nicknameTextFieldText: Observable<String?> = Observable(nil)
        let profileImage: Observable<Data?> = Observable(nil)
        let closeButtonTapped: Observable<Void?> = Observable(nil)
        
        let eButton: Observable<UIButton> = Observable(UIButton())
        let iButton: Observable<UIButton> = Observable(UIButton())
        let sButton: Observable<UIButton> = Observable(UIButton())
        let nButton: Observable<UIButton> = Observable(UIButton())
        let tButton: Observable<UIButton> = Observable(UIButton())
        let fButton: Observable<UIButton> = Observable(UIButton())
        let jButton: Observable<UIButton> = Observable(UIButton())
        let pButton: Observable<UIButton> = Observable(UIButton())
    }
    
    struct Output {
        let profileImage: Observable<UIImage?> = Observable(nil)
        let imageViewTapped: Observable<Void?> = Observable(nil)
        let statusLabelText: Observable<String> = Observable("") // 상태레이블에 표시될 텍스트
        let statusLabelTextColor: Observable<Bool> = Observable(false) // 상태레이블 텍스트컬러
        let doneButtonEnabled: Observable<Bool> = Observable(false) // isNicknameValidate, isButtonValidate 두 조건이 모두 만족됐을때의 값
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
            self.output.doneButtonEnabled.value = self.isDoneButtonEnabled()
        }
        
        [input.eButton, input.iButton].forEach {
            $0.lazyBind { button in
                print("inputMbtiEIButtonTapped bind")
                self.mbtiMbtiButtonArray = [self.input.eButton.value, self.input.iButton.value]
                self.toggleButton(button, array: self.mbtiMbtiButtonArray)
                self.validateButton()
                self.output.doneButtonEnabled.value = self.isDoneButtonEnabled()
            }
        }
        
        [input.sButton, input.nButton].forEach {
            $0.lazyBind { button in
                print("inputMbtiEIButtonTapped bind")
                self.mbtiMbtiButtonArray = [self.input.sButton.value, self.input.nButton.value]
                self.toggleButton(button, array: self.mbtiMbtiButtonArray)
                self.validateButton()
                self.output.doneButtonEnabled.value = self.isDoneButtonEnabled()
            }
        }
        
        [input.tButton, input.fButton].forEach {
            $0.lazyBind { button in
                print("inputMbtiEIButtonTapped bind")
                self.mbtiMbtiButtonArray = [self.input.tButton.value, self.input.fButton.value]
                self.toggleButton(button, array: self.mbtiMbtiButtonArray)
                self.validateButton()
                self.output.doneButtonEnabled.value = self.isDoneButtonEnabled()
            }
        }
        
        [input.jButton, input.pButton].forEach {
            $0.lazyBind { button in
                print("inputMbtiEIButtonTapped bind")
                self.mbtiMbtiButtonArray = [self.input.jButton.value, self.input.pButton.value]
                self.toggleButton(button, array: self.mbtiMbtiButtonArray)
                self.validateButton()
                self.output.doneButtonEnabled.value = self.isDoneButtonEnabled()
            }
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
        if let image = value.userInfo!["image"] as? UIImage {
            output.profileImage.value = image
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
            self.output.statusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else if spacialRange != nil {
            self.output.statusLabelText.value = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            self.output.statusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else if decimalRange != nil {
            self.output.statusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            self.output.statusLabelTextColor.value = false
            self.isNicknameValidate = false
        } else {
            self.output.statusLabelText.value = "사용할 수 있는 닉네임이에요"
            self.output.statusLabelTextColor.value = true
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
        if (input.eButton.value.isSelected || input.iButton.value.isSelected) &&
            (input.sButton.value.isSelected || input.nButton.value.isSelected) &&
            (input.tButton.value.isSelected || input.fButton.value.isSelected) &&
            (input.jButton.value.isSelected || input.pButton.value.isSelected) {
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
            reSaveImage?(input.profileImage.value ?? Data())
            reSaveNickname?(input.nicknameTextFieldText.value ?? "")
        } else {
            UserDefaultsManager.shared.nickname = input.nicknameTextFieldText.value ?? ""
            UserDefaultsManager.shared.joinDate = Date().toJoinString()
            if let imageData = input.profileImage.value {
                UserDefaultsManager.shared.profileImage = imageData
            }
        }
    }
}
