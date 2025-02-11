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
    }
    
    struct Output {
        let movieList: Observable<[MovieDetail]> = Observable([])
        let searchList: Observable<[String]> = Observable([])
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
}
