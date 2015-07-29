//
//  ShowSeasonsViewController.swift
//  united Series
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import TraktModels

class ShowSeasonsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
     var id : String!
    var seasonName : String!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var seasonTableView: UITableView!
    
    
    private let httpClient = TraktHTTPClient()
    private var seasons: [Season] = []
    func loadSeasons() {
        httpClient.getSeasons(id){ [weak self] result in
            if let result = result.value {
                for i in result
                {
                    if i.airedEpisodes > 0
                    {
                        self?.seasons.insert(i, atIndex: 0)
                        
                    }
                }
                self?.seasons.sort({ $0.number > $1.number})
                
                self?.seasonTableView.reloadData()
                
            } else {
                println("oops \(result.error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSeasons()
        self.title = seasonName
        if FavoritesManager().favoritesIdentifiers.contains(id.toInt()!)
        {
            favoriteButton.tintColor = UIColor.redColor()

        }
        else
        {
            favoriteButton.tintColor = UIColor.blackColor()



            
        }

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToSeason"
        {
            if let cellRow = sender as? Int
            {
                let seasonViewController : SeasonViewController = segue.destinationViewController as! SeasonViewController
                seasonViewController.seasonId = cellRow.description
                seasonViewController.id = id
                
            }
            
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.seasons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.seasonCell.identifier
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier!, forIndexPath: indexPath) as! UITableViewCell
        let newCell = cell as! SeasonTableViewCell
        newCell.loadSeason(seasons[indexPath.row])
        
        
        return newCell
        
        
    }
    
    @IBAction func favorite(sender: AnyObject) {
        
        if FavoritesManager().favoritesIdentifiers.contains(id.toInt()!)
        {
            FavoritesManager().removeIdentifier(id.toInt()!)
            println("removi \(id)")
            favoriteButton.tintColor = UIColor.blackColor()

            
        }
        else
        {
            FavoritesManager().addIdentifier(id.toInt()!)
            println("adicionei \(id)")
            favoriteButton.tintColor = UIColor.redColor()

        }
        //did change

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName("favoritesChanged", object: self)
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.seasonTableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("goToSeason", sender: seasons[indexPath.row].number)
        
        
        
    }
    

    
    
    
    
    

}
