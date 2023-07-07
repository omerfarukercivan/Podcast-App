//
//  PodcastCell.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 5.07.2023.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            guard let url = URL(string: podcast.artworkUrl600?.toSecureHTTPS() ?? "") else { return }
            
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            podcastImageView.sd_setImage(with: url)
        }
    }
}
