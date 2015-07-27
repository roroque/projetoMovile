//
//  SeasonViewController.swift
//  united Series
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels

class SeasonViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var seriesList  : NSMutableArray = []
    var id : String!
    var seasonId:String?
    @IBOutlet weak var episodesTableView: UITableView!
    
    
    private let httpClient = TraktHTTPClient()
    private var episodes: [Episode] = []
    func loadEpisodes() {
        httpClient.getEpisodes(id, season: seasonId!.toInt()!) { [weak self] result in
            if let episodes = result.value {
                self?.episodes = episodes
                
                self?.episodesTableView.reloadData()
                
            } else {
                println("oops \(result.error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Season \(seasonId!)"

        
        self.loadEpisodes()
        
        // Do any additional setup after loading the view.
    }
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToEpisode"
        {
            if let cellRow = sender as? Int
            {
                let episodeViewController : EpisodeViewController = segue.destinationViewController as! EpisodeViewController
                episodeViewController.episode = episodes[cellRow]
                episodeViewController.seasonId = seasonId!
                episodeViewController.id = id

            }
            
        }
        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.basicCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
        let newCell = cell as! CustomTableViewCell
        
        
        newCell.subtitleLabel.text = self.episodes[indexPath.row].title
        newCell.titleLabel.text = "Ep\(self.episodes[indexPath.row].number)Se\(self.episodes[indexPath.row].seasonNumber)"

        
        return newCell
        
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.episodesTableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("goToEpisode", sender: indexPath.row)
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
