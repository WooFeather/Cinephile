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
        
    }
    
    struct Output {
        let movieData: Observable<MovieDetail?> = Observable(nil)
        var firstGenre: String?
        var secondGenre: String?
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
    }
}
