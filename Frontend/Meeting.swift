//
//  Meeting.swift
//  Frontend
//
//  Created by Vernon Chan on 3/10/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation

struct MeetingSchedule : Codable {
    var frequency: Int // 1-4 number of weeks between each meeting, e.g. 2 -> every 2 weeks
    var startingDate: Date
    var numItemsExpected: Int
    
    init(frequency: Int, startingDate: Date, numItemsExpected: Int) {
        self.frequency = frequency
        self.startingDate = startingDate
        self.numItemsExpected = numItemsExpected
    }
}

class Meeting : Codable {
    var userId: String
    var artisanId: String
    var date: Date
    var numItemsExpected: Int
    
    init(userId: String, artisanId: String, date: Date, numItemsExpected: Int) {
        self.userId = userId
        self.artisanId = artisanId
        self.date = date
        self.numItemsExpected = numItemsExpected
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return [
            "userID": self.userId as AnyObject,
            "artisanID": self.artisanId as AnyObject,
            "date": dateFormatter.string(from: self.date) as AnyObject,
            "itemsExpected": self.numItemsExpected as AnyObject
        ]
    }
}
