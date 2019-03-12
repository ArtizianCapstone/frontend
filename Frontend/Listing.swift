//
//  Listings.swift
//  Frontend
//
//  Created by Zane Ali on 2/7/19.
//  Copyright © 2019 Artizian. All rights reserved.
//
import UIKit

class Listing {
    
    var name: String = "temp"
    var artisan: String = "temp"
    var description: String = "temp"
    var price: Float = 0.0
    var quantity : Int = 1
    var photo: UIImage?

    func toJSON() -> Dictionary<String, AnyObject>
    {
        return [ 
            "name": self.name as AnyObject,
            "description": self.description as AnyObject,
            "price": self.price as AnyObject,
            "artisanID": self.artisan as AnyObject,
            "userID": "5c00776e2f1dfe588f33138c" as AnyObject,
            "quantity": 0 as AnyObject
        ]
    }
}

