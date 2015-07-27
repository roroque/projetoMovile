//
//  ShowsViewController.swift
//  united Series
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels

class ShowsViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource {

    
    
   // var showsList  : NSMutableArray = []

    @IBOutlet weak var popularCollectionView: UICollectionView!
    var images : [NSData] = []
    var selectedSeasonName : String?
    
    
    
    private let httpClient = TraktHTTPClient()
    private var shows: [Show] = []
    func loadShows() {
        httpClient.getPopularShows { [weak self] result in
        if let shows = result.value {
            self?.shows = shows

            
            self!.popularCollectionView.reloadData()
    } else {
        println("oops \(result.error)")
        } }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shows"
        self.loadShows()
       
        
        //showsList.addObject(["title":"Breaking Bad","images":"http://otvfoco.com.br/wp-content/uploads/2015/02/post219.jpg"])


        
        
        self.popularCollectionView.reloadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space,bottom: flowLayout.sectionInset.bottom, right: space)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let identifiers =  shows[indexPath.row].identifiers
        selectedSeasonName = shows[indexPath.row].title
        
        self.performSegueWithIdentifier("goToSeasons", sender: identifiers.trakt.description)

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(Reusable.collectionCell, forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.prepareForReuse()
        
        cell.loadShow(shows[indexPath.row])
        
        return cell
        
        
    }
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
          
            if segue.identifier == "goToSeasons"
            {
                let seasonViewController : ShowSeasonsViewController = segue.destinationViewController as! ShowSeasonsViewController
                print(sender as! String)
                seasonViewController.id = sender as! String
                seasonViewController.seasonName = selectedSeasonName
            }
        
        
            
    }

}
