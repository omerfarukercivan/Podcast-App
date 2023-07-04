//
//  SearchController.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 4.07.2023.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    
    let cellId = "cellid"
    let searchController = UISearchController(searchResultsController: nil)
    let podcasts = [
        Podcast(name: "1", artistName: "Ömer"),
        Podcast(name: "2", artistName: "Faruk")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupsearchBar()
        setupTableView()
    }
    
    fileprivate func setupsearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        
        return cell
    }
    
}
