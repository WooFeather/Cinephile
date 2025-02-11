//
//  CinemaViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/11/25.
//

import Foundation

final class CinemaViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
        let viewWillAppearTrigger: Observable<Void?> = Observable(nil)
        let searchButtonTapped: Observable<Void?> = Observable(nil)
        let backgroundViewTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let movieList: Observable<[MovieDetail]> = Observable([])
        let searchList: Observable<[String]> = Observable([])
        let imageDataContents: Observable<Data> = Observable(Data())
        let nicknameContents: Observable<String?> = Observable(nil)
        let searchButtonTapped: Observable<Void?> = Observable(nil)
        let backgroundViewTapped: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    // MARK: - Functions
    func transform() {
        input.viewDidLoadTrigger.lazyBind { _ in
            self.callRequest()
            self.receiveSearchText()
            self.output.searchList.value = UserDefaultsManager.shared.searchList
            LikeMovie.likeMovieIdList = UserDefaultsManager.shared.likeMovieIdList
        }
        
        input.viewWillAppearTrigger.lazyBind { _ in
            self.saveUserDefaultsValue()
        }
        
        input.searchButtonTapped.bind { _ in
            self.output.searchButtonTapped.value = ()
        }
        
        input.backgroundViewTapped.bind { _ in
            self.dataTransfer()
        }
    }
    
    private func callRequest() {
        NetworkManager.shared.callTMDBAPI(api: .trending, type: Movie.self) { value in
            self.output.movieList.value = value.results
        } failHandler: {
            print("네트워킹 실패")
        }
    }
    
    private func receiveSearchText() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(searchTextReceivedNotification),
            name: NSNotification.Name("SearchTextReceived"),
            object: nil
        )
    }
    
    @objc
    private func searchTextReceivedNotification(value: NSNotification) {
        if let searchText = value.userInfo!["searchText"] as? String {
            output.searchList.value.insert(searchText, at: 0)
            UserDefaultsManager.shared.searchList = output.searchList.value
        } else {
            return
        }
    }
    
    private func saveUserDefaultsValue() {
        // UserDefaults에 저장된 이미지, 닉네임 데이터 담기
        output.imageDataContents.value = UserDefaultsManager.shared.profileImage
        output.nicknameContents.value = UserDefaultsManager.shared.nickname
    }
    
    private func dataTransfer() {
        output.imageDataContents.value = UserDefaultsManager.shared.profileImage
        output.nicknameContents.value = UserDefaultsManager.shared.nickname
        self.output.backgroundViewTapped.value = ()
    }
}
