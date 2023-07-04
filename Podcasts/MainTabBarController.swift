//
//  MainTabBarController().swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 4.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .purple
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: SearchController(), title: "Search", image: "magnifyingglass"),
            generateNavigationController(for: ViewController(), title: "Favorites", image: "play.circle"),
            
            generateNavigationController(for: ViewController(), title: "Downloads", image: "rectangle.stack.fill")
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        
        return navController
    }
}
