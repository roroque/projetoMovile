//
//  SeasonTableViewCell.swift
//  united Series
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Kingfisher
import FloatRatingView
import TraktModels


class SeasonTableViewCell: UITableViewCell {

    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var seasonNumberLabel: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    private var task: RetrieveImageTask?

    
    func loadSeason(season: Season) {
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.fullImageURL ?? season.poster?.mediumImageURL ?? season.poster?.thumbImageURL {
            task =  seasonImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            seasonImage.image = placeholder
        }
        seasonNumberLabel.text = "Season \(season.number)"
        episodeNumberLabel.text = "\(season.episodeCount!) episodes"
        ratingView.rating = season.rating!
        rating.text = season.rating!.description.substringToIndex(season.rating!.description.startIndex.successor().successor().successor())
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        seasonImage.image = nil
    }
    

    
    
    
}
