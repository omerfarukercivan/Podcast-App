//
//  EpisodesController.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 5.07.2023.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    var podcasts: Podcast? {
        didSet {
            navigationItem.title = podcasts?.trackName
            fetchEpisodes()
        }
    }
    
    var episodes = [Episode]()
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarButtons()
    }
    
    fileprivate func fetchEpisodes() {
        guard let feedUrl = podcasts?.feedUrl else { return }
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { episodes in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Setup
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavigationBarButtons() {
        let savedPodcast = UserDefaults.standard.savedPodcasts()
        let hasFavorited = savedPodcast.firstIndex(where: { $0.trackName == self.podcasts?.trackName && $0.artistName == self.podcasts?.artistName }) != nil
        
        if hasFavorited {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: nil, action: nil)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)) 
        }
    }
    
    fileprivate func showBadgeHighlight() {
        UIApplication.mainTabBarController()?.viewControllers?[0].tabBarItem.badgeValue = "New"
    }
    
    // MARK: UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        
        cell.episode = episode
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainTabBarController = UIApplication.mainTabBarController()
        let episode = episodes[indexPath.row]
        
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
    // MARK: Selector
    @objc func handleSaveFavorite() {
        guard let podcast = self.podcasts else { return }
        
        var listOfPodcast = UserDefaults.standard.savedPodcasts()
        listOfPodcast.append(podcast)
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfPodcast)
        
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
        showBadgeHighlight()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: nil, action: nil)
    }
    
    @objc func handleFetchSavedFavorites() {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey ) else { return }
        let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Podcast]
        
        podcast?.forEach({ p in
            print(p.trackName ?? "", p.artistName ?? "")
        })
    }
}
