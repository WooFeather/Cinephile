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
        let removeButtonTapped: Observable<Int> = Observable(-1)
        let clearButtonTapped: Observable<Void?> = Observable(nil)
        let likeButtonTapped: Observable<Int> = Observable(-1)
        let searchTextTapped: Observable<Int> = Observable(-1)
        let movieTapped: Observable<Int> = Observable(-1)
        let imageReSave: Observable<Data> = Observable(Data())
        let nicknameReSave: Observable<String> = Observable("")
    }
    
    struct Output {
        let movieList: Observable<[MovieDetail]> = Observable([])
        let searchList: Observable<[String]> = Observable([])
        let imageDataContents: Observable<Data> = Observable(Data())
        let nicknameContents: Observable<String> = Observable("")
        let searchButtonTapped: Observable<Void?> = Observable(nil)
        let backgroundViewTapped: Observable<Void?> = Observable(nil)
        let likeButtonTapped: Observable<Void?> = Observable(nil)
        let searchText: Observable<String> = Observable("")
        let movieData: Observable<MovieDetail?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("CinemaViewModel Init")
        
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("CinemaViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.callRequest()
            self?.receiveSearchText()
            self?.output.searchList.value = UserDefaultsManager.shared.searchList
            LikeMovie.likeMovieIdList = UserDefaultsManager.shared.likeMovieIdList
        }
        
        input.viewWillAppearTrigger.lazyBind { [weak self] _ in
            self?.saveUserDefaultsValue()
        }
        
        input.searchButtonTapped.bind { [weak self] _ in
            self?.output.searchButtonTapped.value = ()
        }
        
        input.backgroundViewTapped.bind { [weak self] _ in
            self?.profileDataTransfer()
        }
        
        input.removeButtonTapped.lazyBind { [weak self] tag in
            self?.removeSearchText(tag: tag)
        }
        
        input.clearButtonTapped.lazyBind { [weak self] _ in
            self?.clearSearchList()
        }
        
        input.likeButtonTapped.lazyBind { [weak self] tag in
            self?.likeMovie(tag: tag)
        }
        
        input.searchTextTapped.lazyBind { [weak self] index in
            self?.textTransfer(index: index)
        }
        
        input.movieTapped.lazyBind { [weak self] index in
            self?.movieDataTransfer(index: index)
        }
        
        input.imageReSave.lazyBind { [weak self] data in
            self?.reSaveImage(data: data)
        }
        
        input.nicknameReSave.lazyBind { text in
            self.reSaveNickname(text: text)
        }
    }
    
    private func callRequest() {
        NetworkManager.shared.callTMDBAPI(api: .trending, type: Movie.self) { [weak self] value in
            self?.output.movieList.value = value.results
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
    
    private func profileDataTransfer() {
        output.imageDataContents.value = UserDefaultsManager.shared.profileImage
        output.nicknameContents.value = UserDefaultsManager.shared.nickname
        self.output.backgroundViewTapped.value = ()
    }
    
    private func removeSearchText(tag: Int) {
        output.searchList.value.remove(at: tag)
        UserDefaultsManager.shared.searchList = output.searchList.value
    }
    
    private func clearSearchList() {
        output.searchList.value.removeAll()
        UserDefaultsManager.shared.searchList = output.searchList.value
    }
    
    private func likeMovie(tag: Int) {
        // likeMovieIdList라는 배열에 선택한 영화의 id가 있으면 삭제하고, 없으면 등록하는 toggle형식의 동작
        // 동시에 LikeCount도 반영
        let item = output.movieList.value[tag]
        if LikeMovie.likeMovieIdList.contains(item.id) {
            if let index = LikeMovie.likeMovieIdList.firstIndex(of: item.id) {
                LikeMovie.likeMovieIdList.remove(at: index)
                UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
                UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
            }
        } else {
            LikeMovie.likeMovieIdList.append(item.id)
            UserDefaultsManager.shared.likeMovieIdList = LikeMovie.likeMovieIdList
            UserDefaultsManager.shared.likeCount = LikeMovie.likeMovieIdList.count
        }
        
        print(LikeMovie.likeMovieIdList)
        print(LikeMovie.likeMovieIdList.count)
        
        output.likeButtonTapped.value = ()
    }
    
    private func textTransfer(index: Int) {
        output.searchText.value = output.searchList.value[index]
    }
    
    private func movieDataTransfer(index: Int) {
        output.movieData.value = output.movieList.value[index]
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
