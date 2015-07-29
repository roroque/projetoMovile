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
    @IBOutlet weak var segmentedOptions: UISegmentedControl!

    @IBOutlet weak var popularCollectionView: UICollectionView!
    var images : [NSData] = []
    var selectedSeasonName : String?
    var presentedShows : [Show] = []
    var page = 1
    
    
    
    private let httpClient = TraktHTTPClient()
    private var shows: [Show] = []
    func loadShows() {
        httpClient.getPopularShows(page) { [weak self] result in
        if let shows = result.value {
            for i in shows
            {
                self?.shows.append(i)
            }
            self?.presentedShows = self!.shows
            self?.loadSelected()

            
            self!.popularCollectionView.reloadData()
    } else {
        println("oops \(result.error)")
        } }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let x = FavoritesManager()
        println(x.favoritesIdentifiers)
        //loadSelected()
        self.navigationController?.navigationBar.hideBottomHairline()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.showBottomHairline()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shows"
        self.loadShows()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "loadSelected", name: "favoritesChanged", object: nil)
        
        //showsList.addObject(["title":"Breaking Bad","images":"http://otvfoco.com.br/wp-content/uploads/2015/02/post219.jpg"])
        self.popularCollectionView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    deinit
    {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: "favoritesChanged", object: nil)
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
        return presentedShows.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let identifiers =  presentedShows[indexPath.row].identifiers
        selectedSeasonName = presentedShows[indexPath.row].title
       
        
        self.performSegueWithIdentifier("goToSeasons", sender: identifiers.trakt.description)

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(Reusable.collectionCell, forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.prepareForReuse()
        
        cell.loadShow(presentedShows[indexPath.row])
        if segmentedOptions.selectedSegmentIndex == 0
        {
            if indexPath.row == presentedShows.count - 1
            {
                self.page++
                self.loadShows()
            }
        }

        
        
        return cell
        
        
    }
    

    @IBAction func changedEvent(sender: AnyObject) {
        loadSelected()
        
    }
    
    
    
    func loadSelected()
    {
        if segmentedOptions.selectedSegmentIndex == 0
        {
            presentedShows = shows
            popularCollectionView.reloadData()
        }
        else
        {
            presentedShows = presentedShows.filter({ (T) -> Bool in
                
                println(FavoritesManager().favoritesIdentifiers.contains(T.identifiers.trakt))
                return FavoritesManager().favoritesIdentifiers.contains(T.identifiers.trakt)
                
                
            })
            
            popularCollectionView.reloadData()
            
        }
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
