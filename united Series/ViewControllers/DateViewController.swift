//
//  DateViewController.swift
//  united Series
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        
        println("\(self.dynamicType) deinit")
        
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
