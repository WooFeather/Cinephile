//
//  ImageSettingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/9/25.
//

import UIKit

final class ImageSettingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
        let viewWillDisappearTrigger: Observable<Void?> = Observable(nil)
        let profileImage: Observable<UIImage?> = Observable(nil)
        let cellSelected: Observable<ProfileImage?> = Observable(nil)
    }
    
    struct Output {
        let profileImage: Observable<UIImage?> = Observable(nil)
        let cellSelected: Observable<ProfileImage?> = Observable(nil)
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
        input.profileImage.lazyBind { image in
            self.saveImage()
        }
        
        input.cellSelected.lazyBind { _ in
            self.output.cellSelected.value = self.input.cellSelected.value
        }
    }
    
    private func saveImage() {
        guard let imageValue = input.profileImage.value else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("ImageReceived"),
            object: nil,
            userInfo: [
                "image": imageValue
            ]
        )
    }
}
