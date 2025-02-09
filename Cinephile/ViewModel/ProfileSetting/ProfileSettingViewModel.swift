//
//  ProfileSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

import UIKit

final class ProfileSettingViewModel {
    
    let inputImageViewTapped: Observable<Void?> = Observable(nil)
    let inputNicknameTextFieldEditingChanged: Observable<String?> = Observable(nil)
    let inputMbtiEIButtonTapped: Observable<UIButton?> = Observable(nil)
    let inputMbtiSNButtonTapped: Observable<UIButton?> = Observable(nil)
    let inputMbtiTFButtonTapped: Observable<UIButton?> = Observable(nil)
    let inputMbtiJPButtonTapped: Observable<UIButton?> = Observable(nil)
    
    let outputImageViewTapped: Observable<Void?> = Observable(nil)
    let outputStatusLabelText: Observable<String> = Observable("") // 상태레이블에 표시될 텍스트
    let outputNicknameValidate: Observable<Bool> = Observable(false) // 상태레이블 텍스트컬러와 isNicknameValidate 변수에 들어갈 값
    let outputMbtiEIButtonTapped: Observable<UIButton?> = Observable(nil)
    let outputMbtiSNButtonTapped: Observable<UIButton?> = Observable(nil)
    let outputMbtiTFButtonTapped: Observable<UIButton?> = Observable(nil)
    let outputMbtiJPButtonTapped: Observable<UIButton?> = Observable(nil)
    // let outputButtonValidate: Observable<Bool> = Observable(false) // isButtonValidate 변수에 들어갈 값(mbti button이 전부 선택되었는지 확인)
    // let outputDoneButtonEnabled: Observable<Bool> = Observable(false) // isNicknameValidate, isButtonValidate 두 조건이 모두 만족됐을때의 값
    
    // MARK: - Initializer
    init() {
        print("ProfileSettingViewModel Init")
        
        inputImageViewTapped.lazyBind { _ in
            print("inputImageViewTapped bind")
            self.outputImageViewTapped.value = ()
        }
        
        inputNicknameTextFieldEditingChanged.lazyBind { _ in
            self.validateText()
        }
        
        inputMbtiEIButtonTapped.lazyBind { button in
            print("inputMbtiEIButtonTapped bind")
            self.outputMbtiEIButtonTapped.value = button
        }
        
        inputMbtiSNButtonTapped.lazyBind { button in
            print("inputMbtiSNButtonTapped bind")
            self.outputMbtiSNButtonTapped.value = button
        }
        
        inputMbtiTFButtonTapped.lazyBind { button in
            print("inputMbtiTFButtonTapped bind")
            self.outputMbtiTFButtonTapped.value = button
        }
        
        inputMbtiJPButtonTapped.lazyBind { button in
            print("inputMbtiJPButtonTapped bind")
            self.outputMbtiJPButtonTapped.value = button
        }
    }
    
    deinit {
        print("ProfileSettingViewModel Deinit")
    }
    
    // MARK: - Functions
    
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
            self.outputNicknameValidate.value = false
            // TODO: mbti버튼의 조건과 더불어 outputDoneButtonEnabled값 설정
//            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
//            if UserDefaultsManager.shared.isSigned {
//                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
//            }
        } else if spacialRange != nil {
            self.outputStatusLabelText.value = "닉네임에 @, #, $, % 는 포함될 수 없어요"
            self.outputNicknameValidate.value = false
//            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
//            if UserDefaultsManager.shared.isSigned {
//                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
//            }
        } else if decimalRange != nil {
            self.outputStatusLabelText.value = "닉네임에 숫자는 포함할 수 없어요"
            self.outputNicknameValidate.value = false
//            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
//            if UserDefaultsManager.shared.isSigned {
//                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
//            }
        } else {
            self.outputStatusLabelText.value = "사용할 수 있는 닉네임이에요"
            self.outputNicknameValidate.value = true
//            profileSettingView.doneButton.isEnabled = isDoneButtonEnabled()
//            if UserDefaultsManager.shared.isSigned {
//                navigationItem.rightBarButtonItem?.isEnabled = isDoneButtonEnabled()
//            }
        }
    }
}
