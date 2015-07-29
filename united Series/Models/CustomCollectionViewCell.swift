//
//  CustomCollectionViewCell.swift
//  united Series
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Kingfisher
import TraktModels

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    private var task: RetrieveImageTask?
    
    
    
    func loadShow(show: Show) {
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.fullImageURL ?? show.poster?.mediumImageURL ?? show.poster?.thumbImageURL {
        task =  image.kf_setImageWithURL(url, placeholderImage: placeholder)
    } else {
        image.image = placeholder
        }
        title.text = show.title
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            task?.cancel()
            task = nil
            image.image = nil
    }
    deinit
    {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    
    
    
    
}
