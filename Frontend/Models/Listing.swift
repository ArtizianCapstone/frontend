//
//  Listings.swift
//  Frontend
//
//  Created by Zane Ali on 2/7/19.
//  Copyright © 2019 Artizian. All rights reserved.
//
import UIKit

class Listing {
    var _id: String = "temp"
    var name: String = "temp"
    var artisanId: String = "temp"
    var artisanName: String = "temp"
    var description: String = "temp"
    var price: Float = 0.0
    var creation_date: Date
    var quantity : Int = 1
    var photo: UIImage?
    var photo_url: String?
    
    init() {
        self.name = "temp"
        self.artisanId = "temp"
        self.description = "temp"
        self.price = 0
        self.creation_date = Date()
    }
    
    init(_id: String, name: String, artisanId: String, price:Float, description:String, creation_date: Date, quantity:Int, photo_url:String) {
        self._id = _id
        self.name = name
        self.artisanId = artisanId
        self.description = description
        self.price = price
        self.creation_date = creation_date
        self.quantity = quantity
        self.photo_url = photo_url
    }
    

    func toJSON() -> Dictionary<String, AnyObject>
    {
        return [ 
            "name": self.name as AnyObject,
            "description": self.description as AnyObject,
            "price": self.price as AnyObject,
            "artisanID": self.artisanId as AnyObject,
            "userID": Constants.userID as AnyObject,
            "quantity": 0 as AnyObject
        ]
    }
    
    func toStrDict() -> [String : String] {
        return ["name": self.name,
                "description": self.description,
                "price": "\(self.price)",
                "artisanID": self.artisanId,
                "userID": Constants.userID,
                "quantity": "0"]
    }
}

