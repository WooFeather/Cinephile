//
//  BaseViewModel.swift
//  Cinephile
//
//  Created by 조우현 on 2/11/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform()
}
