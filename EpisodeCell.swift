//
//  EpisodeCell.swift
//  Podcasts
//
//  Created by Ömer Faruk Ercivan on 5.07.2023.
//

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var episode: Episode! {
        didSet {
            let dateFormatter = DateFormatter()
            let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "")
            dateFormatter.dateFormat = "dd MMMM YYYY"
            
            episodeImageView.sd_setImage(with: url)
            pubDateLabel.text = dateFormatter.string(from: episode!.pubDate)
            titleLabel.text = episode?.title
            descriptionLabel.text = episode?.description
            
            titleLabel.numberOfLines = 2
            descriptionLabel.numberOfLines = 2
        }
    }
}
