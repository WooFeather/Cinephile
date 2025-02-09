//
//  ImageSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

import UIKit

final class ImageSettingViewModel {
    
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    let inputViewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    let inputProfileImage: Observable<UIImage?> = Observable(nil)
    let inputCellSelected: Observable<ProfileImage?> = Observable(nil)
    
    let outputProfileImage: Observable<UIImage?> = Observable(nil)
    let outputCellSelected: Observable<ProfileImage?> = Observable(nil)
    
    // MARK: - Initializer
    init() {
        print("ProfileSettingViewModel Init")
        
        inputProfileImage.lazyBind { image in
            self.saveImage()
        }
        
        inputCellSelected.lazyBind { _ in
            self.outputCellSelected.value = self.inputCellSelected.value
        }
    }
    
    deinit {
        print("ProfileSettingViewModel Deinit")
    }
    
    // MARK: - Functions
    private func saveImage() {
        guard let imageValue = inputProfileImage.value else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("ImageReceived"),
            object: nil,
            userInfo: [
                "image": imageValue
            ]
        )
    }
}
