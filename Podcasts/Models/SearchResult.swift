//
//  SearchResult.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 5.07.2023.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Podcast]
}
