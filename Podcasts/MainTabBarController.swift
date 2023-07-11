//
//  MainTabBarController().swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 4.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    let playerDetailsView = PlayerDetailsView.initFromNib()
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchortConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        tabBar.tintColor = .purple
        setupViewControllers()
        setupPlayerDetailsView()
    }
    
    // MARK: Setup
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: SearchController(), title: "Search", image: "magnifyingglass"),
            generateNavigationController(for: ViewController(), title: "Favorites", image: "play.circle"),
            generateNavigationController(for: ViewController(), title: "Downloads", image: "rectangle.stack.fill")
        ]
    }
    
    func setupPlayerDetailsView() {
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchortConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchortConstraint.isActive = true
    }
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        
        return navController
    }
    
    func minimizePlayerDetails() {
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchortConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1) {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
            
            self.playerDetailsView.maximizedStackView.alpha = 0
            self.playerDetailsView.miniPlayerView.alpha = 1
        }
    }
    
    func maximizePlayerDetails(episode: Episode?, playlistEpisodes: [Episode] = []) {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchortConstraint.constant = 0
        
        if episode != nil {
            playerDetailsView.episode = episode
        }
        
        playerDetailsView.playlistEpisodes = playlistEpisodes  
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1) {
            self.view.layoutIfNeeded()
            self.tabBar.frame.origin.y = self.view.frame.size.height
            
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
        }
    }
}
