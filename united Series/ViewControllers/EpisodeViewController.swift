//
//  EpisodeViewController.swift
//  united Series
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels
import TUSafariActivity

class EpisodeViewController: UIViewController {

    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    var episode : Episode!
    var id : String!
    var seasonId : String!
    var epNum : String!
    
    func loadEpisode() {
     
        self.title = "Episode \(episode.number)"
        overviewTextView.text = episode.overview
        titleLabel.text = episode.title
        image.image = UIImage(data: NSData(contentsOfURL: episode.screenshot!.fullImageURL!)!)
        
        
      
    }
    
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
        self.loadEpisode()
      //  self.loadEpisode()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    @IBAction func shareURL(sender: AnyObject) {
        
        //print("https://trakt.tv/shows/\(id)/seasons/\(seasonId)/episodes/\(episode.number)")
        
        let selectedEpisodeUrl = NSURL(string: "https://trakt.tv/shows/\(id)/seasons/\(seasonId)/episodes/\(episode.number)")!
        let safariActivity = TUSafariActivity()
        
        let shareViewController = UIActivityViewController(activityItems: [selectedEpisodeUrl], applicationActivities: [safariActivity])
        self.presentViewController(shareViewController, animated: true) { () -> Void in
            
            
        }
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
