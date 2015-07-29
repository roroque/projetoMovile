//
//  FavoritesManager.swift
//  united Series
//
//  Created by iOS on 7/28/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import UIKit

class FavoritesManager{
    
    
    let Default =  NSUserDefaults.standardUserDefaults()
    deinit
    {
        
        println("\(self.dynamicType) deinit")
        
    }
    
    var favoritesIdentifiers : Set<Int>
    {
        
        if let vect = Default.objectForKey("identifiers") as? [Int]
        {
            return Set<Int>(vect)

        }
       
        return Set<Int>()
    }
    
    func addIdentifier(identifier: Int)
    {
        
        if let var identifiers = Default.objectForKey("identifiers") as? [Int]
        {
            identifiers.append(identifier)
            Default.setObject(identifiers, forKey: "identifiers")
        }
        else
        {
            Default.setObject([identifier], forKey: "identifiers")
        }
        
        Default.synchronize()

        
    }
    
    func removeIdentifier(identifier: Int)
    {
        //println(identifier)
        var identifiers = Default.objectForKey("identifiers") as! [Int]
        for index in 0...identifiers.count
        {
    
            if identifiers[index] == identifier
            {
                identifiers.removeAtIndex(index)
                Default.removeObjectForKey("identifiers")
                Default.setObject(identifiers, forKey: "identifiers")
                Default.synchronize()
                break

            }
        }
        
               // (correctId)
        

       
        
    }
    
   
}
