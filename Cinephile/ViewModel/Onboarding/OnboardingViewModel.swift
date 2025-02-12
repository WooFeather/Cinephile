//
//  OnboardingViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/12/25.
//

import Foundation

final class OnboardingViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let startButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let startButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("OnboardingViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("OnboardingViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        input.startButtonTapped.bind { [weak self] _ in
            self?.output.startButtonTapped.value = ()
        }
    }
}
