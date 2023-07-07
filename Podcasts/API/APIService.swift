//
//  APIService.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 5.07.2023.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    static let shared = APIService()
    let baseiTunesSearchUrl = "https://itunes.apple.com/search"
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let parameters = ["term": searchText, "media": "podcast"]
        
        AF.request(baseiTunesSearchUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            if let err = dataResponse.error {
                print("Failed to contact", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completionHandler(searchResult.results)
            } catch let decodeError {
                print("Failed to decode", decodeError)
            }
        }
    }
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        guard let url = URL(string: feedUrl.toSecureHTTPS()) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
        
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    switch feed {
                    case let .rss(feed):
                        let episodes = feed.toEpisodes()
                        completionHandler(episodes)
                        break
                    case .atom(_):
                        break
                    case .json(_):
                        break
                    }
                case .failure(let error):
                    print("Failed to parse feed: ", error)
                    break
                }
            }
        }
    }
}
