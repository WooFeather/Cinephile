//
//  BaseViewController.swift
//  Cinephile
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        configureView()
        configureEssential()
    }
    
    func configureView() {
        view.backgroundColor = .cineBlack
    }
    
    func configureEssential() { }
}
