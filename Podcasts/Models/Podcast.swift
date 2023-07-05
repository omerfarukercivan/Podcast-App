//
//  Podcast.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 4.07.2023.
//

import Foundation

struct Podcast: Codable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}
