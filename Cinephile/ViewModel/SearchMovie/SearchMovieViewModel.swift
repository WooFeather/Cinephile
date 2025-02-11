//
//  SearchMovieViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/11/25.
//

import Foundation

final class SearchMovieViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void?> = Observable(nil)
        let viewDidAppearTrigger: Observable<Void?> = Observable(nil)
        let searchButtonTapped: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let searchText: Observable<String> = Observable("")
        let viewWillAppearTrigger: Observable<Void?> = Observable(nil)
        let viewDidAppearTrigger: Observable<Void?> = Observable(nil)
        let searchButtonTapped: Observable<Void?> = Observable(nil)
        let queryText: Observable<String> = Observable("")
        let page: Observable<Int> = Observable(1)
        let maxNum: Observable<Int> = Observable(0)
        let searchList: Observable<[MovieDetail]> = Observable([])
        let tableViewHidden: Observable<Bool> = Observable(true)
        let emptyLabelHidden: Observable<Bool> = Observable(true)
    }
    
    // MARK: - Initializer
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    // MARK: - Functions
    func transform() {
        input.viewWillAppearTrigger.bind { _ in
            self.output.viewWillAppearTrigger.value = ()
        }
        
        input.viewDidAppearTrigger.bind { _ in
            self.output.viewDidAppearTrigger.value = ()
        }
        
        input.searchButtonTapped.lazyBind { text in
            guard let text = text else { return }
            self.output.queryText.value = text.trimmingCharacters(in: .whitespaces)
            
            self.output.page.value = 1
            self.callRequest(query: self.output.queryText.value)
            self.postSearchText(text: self.output.queryText.value)
            self.output.searchButtonTapped.value = () // 명시적으로 끝나는 시점 전달
        }
    }
    
    private func callRequest(query: String) {
        NetworkManager.shared.callTMDBAPI(api: .search(query: query, page: output.page.value), type: Movie.self) { value in
            if self.output.page.value == 1 {
                self.output.searchList.value = value.results
            } else {
                self.output.searchList.value.append(contentsOf: value.results)
            }
            
            if self.output.searchList.value.isEmpty {
                self.output.tableViewHidden.value = true
                self.output.emptyLabelHidden.value = false
            } else {
                self.output.tableViewHidden.value = false
                self.output.emptyLabelHidden.value = true
            }
            
            self.output.maxNum.value = value.totalResults
            
            print("====1====", self.output.searchList.value)
        } failHandler: {
            print("❌ 네트워킹 실패")
        }
    }
    
    private func postSearchText(text: String) {
        NotificationCenter.default.post(
            name: NSNotification.Name("SearchTextReceived"),
            object: nil,
            userInfo: [
                "searchText": text
            ]
        )
    }
}
