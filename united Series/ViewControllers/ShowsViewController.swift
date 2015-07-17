//
//  ShowsViewController.swift
//  united Series
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController,UICollectionViewDelegate , UICollectionViewDataSource {

    
    
    var showsList  : NSMutableArray = []

    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shows"
        
        showsList.addObject(["title":"Breaking Bad","images":"http://otvfoco.com.br/wp-content/uploads/2015/02/post219.jpg"])


        
        
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
    
    // collectionView:numberOfItemsInSection: and collectionView:cellForItemAtIndexPath: m
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showsList.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("goToSeason", sender: nil)

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(Reusable.collectionCell, forIndexPath: indexPath) as! CustomCollectionViewCell
        let str = showsList.objectAtIndex(indexPath.row)["images"] as? String
        
        cell.image.image = UIImage(data: NSData(contentsOfURL: NSURL(string:str!)!)!)
        cell.title.text = showsList.objectAtIndex(indexPath.row)["title"] as? String
        
        return cell
        
        
    }
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            if segue.identifier == "goToSeason"
            {
                let seasonViewController : SeasonViewController = segue.destinationViewController as! SeasonViewController
            }
            
            
    }

}
