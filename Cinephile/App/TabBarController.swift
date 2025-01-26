//
//  TabBarController.swift
//  Cinephile
//
//  Created by 조우현 on 1/25/25.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
        setupTabBarAppearance()
        view.backgroundColor = .cineBlack
    }
    
    private func configureTabBarController() {
        tabBar.delegate = self
        
        let firstVC = CinemaViewController()
        let secondVC = UpcomingViewController()
        let thirdVC = ProfileViewController()
        
        firstVC.tabBarItem.image = UIImage(systemName: "popcorn")
        secondVC.tabBarItem.image = UIImage(systemName: "film.stack")
        thirdVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        firstVC.tabBarItem.title = "CINEMA"
        secondVC.tabBarItem.title = "UPCOMING"
        thirdVC.tabBarItem.title = "PROFILE"
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstNav, secondNav, thirdNav], animated: true)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .cineBlack
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .cineAccent
    }
}
