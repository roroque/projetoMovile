//
//  SeasonViewController.swift
//  united Series
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit

class SeasonViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var seriesList  : NSMutableArray = []
    @IBOutlet weak var episodesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seriesList.addObject(["title":"S01E03","subtitle":"Lord Snow"])
        episodesTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToEpisode"
        {
            let episodeViewController : EpisodeViewController = segue.destinationViewController as! EpisodeViewController
        }
        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.basicCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
        let newCell = cell as! CustomTableViewCell
        
        
        newCell.subtitleLabel.text = (seriesList.objectAtIndex(indexPath.row)["subtitle"] as! String)
        newCell.titleLabel.text = (seriesList.objectAtIndex(indexPath.row)["title"] as! String)

        
        return newCell
        
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.episodesTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("goToEpisode", sender: nil)
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
