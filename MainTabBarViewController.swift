//
//  ViewController.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let homeElement = UINavigationController(rootViewController: HomeViewController())
        let upcomingElement = UINavigationController(rootViewController: UpcomingViewController())
        let searchElement = UINavigationController(rootViewController: SearchViewController())
        let downloadElement = UINavigationController(rootViewController: DownloadsViewController())
        
        
        homeElement.tabBarItem.image = UIImage(systemName: "house")
        upcomingElement.tabBarItem.image = UIImage(systemName: "play.circle")
        searchElement.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadElement.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeElement.title = "Home"
        upcomingElement.title = "Coming Soon"
        searchElement.title = "Top Search"
        downloadElement.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeElement, upcomingElement, searchElement, downloadElement], animated: true)
    }
}
