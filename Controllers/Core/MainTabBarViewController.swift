//
//  ViewController.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        self.delegate = self
        
        let homeElement = UINavigationController(rootViewController: HomeViewController())
        let upcomingElement = UINavigationController(rootViewController: UpcomingViewController())
        let downloadElement = UINavigationController(rootViewController: DownloadsViewController())
        
        
        homeElement.tabBarItem.image = UIImage(systemName: "house")
        upcomingElement.tabBarItem.image = UIImage(systemName: "play.circle")
        downloadElement.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeElement.title = "Home"
        upcomingElement.title = "Coming Soon"
        downloadElement.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeElement, upcomingElement, downloadElement], animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navController = viewController as? UINavigationController,
           let homeVC = navController.viewControllers.first as? HomeViewController,
           navController.viewControllers.count == 1,
           selectedViewController == viewController {
            homeVC.scrollToTop()
            return false
        }
        return true
    }
}
