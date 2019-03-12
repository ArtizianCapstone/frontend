/*
//  Artisan.swift
//  Frontend
//
//  Created by Vernon Chan on 12/2/18.
//  Copyright © 2018 Artizian. All rights reserved.
//
*/
import UIKit

struct Artisan : Codable {
    
    //MARK: Properties
    
    var name: String
    var phone_number: String
    var bio: String
    var _id: String
    var scheduledMeetings: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name
        case phone_number
        case bio
        case _id
    }
}
