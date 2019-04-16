/*
//  Artisan.swift
//  Frontend
//
//  Created by Vernon Chan on 12/2/18.
//  Copyright © 2018 Artizian. All rights reserved.
//
*/
import UIKit

class Artisan : Codable {
    
    //MARK: Properties
    
    var name: String
    var phone_number: String
    var bio: String
    var _id: String?
    var scheduledMeetings: Bool = false
    
    init( name: String, phone_number: String, bio: String) {
        self.name = name
        self.phone_number = name
        self.bio = bio
    }
    
    init( name: String, phone_number: String, bio: String, _id: String) {
        self.name = name
        self.phone_number = name
        self.bio = bio
        self._id = _id
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case phone_number
        case bio
        case _id
    }
    
    func toJSON() -> Dictionary<String, AnyObject>
    {
        return [
            "userId": "5c00776e2f1dfe588f33138c" as AnyObject,
            "name": self.name as AnyObject,
            "bio": self.bio as AnyObject,
            "phone_number": self.phone_number as AnyObject,
        ]
    }
}
