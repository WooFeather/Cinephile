//
//  MovieDetailViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/12/25.
//

import Foundation

final class MovieDetailViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let movieData: Observable<MovieDetail?> = Observable(nil)
        var firstGenre: String?
        var secondGenre: String?
        let backdropList: Observable<[Backdrop]> = Observable([])
        let posterList: Observable<[Poster]> = Observable([])
        let castList: Observable<[CastDetail]> = Observable([])
        let viewDidLoadTrigger: Observable<Void?> = Observable(nil)
    }
    
    // MARK: - Initializer
    init() {
        print("MovieDetailViewModel Init")
        input = Input()
        output = Output()
        transform()
    }
    
    deinit {
        print("MovieDetailViewModel Deinit")
    }
    
    // MARK: - Functions
    func transform() {
        output.movieData.bind { [weak self] data in
            guard let data = data else { return }
            if data.genreList.count == 1 {
                self?.output.firstGenre = SearchTableViewCell.genre[data.genreList[0]] ?? ""
            } else if data.genreList.count >= 2 {
                self?.output.firstGenre = SearchTableViewCell.genre[data.genreList[0]] ?? ""
                self?.output.secondGenre = SearchTableViewCell.genre[data.genreList[1]] ?? ""
            }
        }
        
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.callRequest()
        }
    }
    
    private func callRequest() {
        let group = DispatchGroup()
        guard let id = output.movieData.value?.id else { return }
        
        group.enter()
        NetworkManager.shared.callTMDBAPI(api: .images(id: id), type: Images.self) { [weak self] value in
            if value.backdrops.count >= 5 {
                for item in 0..<5 {
                    self?.output.backdropList.value.append(value.backdrops[item])
                }
            } else {
                self?.output.backdropList.value = value.backdrops
            }
            self?.output.posterList.value = value.posters
            group.leave()
        } failHandler: {
            print("네트워킹 실패")
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.callTMDBAPI(api: .credit(id: id), type: Credit.self) { [weak self] value in
            self?.output.castList.value = value.cast
            group.leave()
        } failHandler: {
            print("네트워킹 실패")
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.output.viewDidLoadTrigger.value = ()
        }
    }
}
