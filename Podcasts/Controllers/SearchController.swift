//
//  SearchController.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 4.07.2023.
//

import UIKit
import Alamofire

class SearchController: UITableViewController, UISearchBarDelegate {
    
    fileprivate let cellId = "cellid"
    let searchController = UISearchController(searchResultsController: nil)
    var podcasts = [Podcast]()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupsearchBar()
        setupTableView()
        
        searchBar(searchController.searchBar, textDidChange: "Voong")
    }
    
    fileprivate func setupsearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            APIService.shared.fetchPodcasts(searchText: searchText) { podcasts in
                self.podcasts = podcasts
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: UITableView
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.text = "Please enter a search term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return podcasts.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
        let podcast = self.podcasts[indexPath.row]
        
        episodesController.podcasts = podcast
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        let podcast = self.podcasts[indexPath.row]
        
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    //    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    //
    //        activityIndicatorView.color = .darkGray
    //        activityIndicatorView.startAnimating()
    //
    //        return activityIndicatorView
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return podcasts.isEmpty ? 200 : 0
    //    }
    
    //    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    //        activityIndicatorView.color = .darkGray
    //        activityIndicatorView.startAnimating()
    //        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    //
    //        view.addSubview(activityIndicatorView)
    //        NSLayoutConstraint.activate([
    //            activityIndicatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
    //            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
    //        ])
    //
    //        let label = UILabel()
    //        let attributedText = NSMutableAttributedString(string: "Loading ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
    //        attributedText.append(NSAttributedString(string: "Podcast episode", attributes: [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
    //        label.attributedText = attributedText
    //        label.textAlignment = .center
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //
    //        activityIndicatorView.addSubview(label)
    //        NSLayoutConstraint.activate([
    //            label.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 6),
    //            label.heightAnchor.constraint(equalToConstant: 30),
    //            label.widthAnchor.constraint(equalToConstant: 200),
    //            label.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor)
    //        ])
    //
    //        return activityIndicatorView
    //    }
    
    //    fileprivate func asd() -> UIView? {
    //        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    //        activityIndicatorView.color = .darkGray
    //        activityIndicatorView.startAnimating()
    //        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    //
    //        view.addSubview(activityIndicatorView)
    //        NSLayoutConstraint.activate([
    //            activityIndicatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
    //            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
    //        ])
    //
    //        let label = UILabel()
    //        let attributedText = NSMutableAttributedString(string: "Loading ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
    //        attributedText.append(NSAttributedString(string: "Podcast episode", attributes: [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
    //        label.attributedText = attributedText
    //        label.textAlignment = .center
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //
    //        activityIndicatorView.addSubview(label)
    //        NSLayoutConstraint.activate([
    //            label.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 6),
    //            label.heightAnchor.constraint(equalToConstant: 30),
    //            label.widthAnchor.constraint(equalToConstant: 200),
    //            label.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor)
    //        ])
    //
    //        return activityIndicatorView
    //    }
    
    
    //    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //            return podcasts.isEmpty ? 200 : 0
    //        }
}
