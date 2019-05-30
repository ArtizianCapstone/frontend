//
//  MeetingRetriever.swift
//  Frontend
//
//  Created by Jackson Kurtz on 5/23/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
import Alamofire

class MeetingRetriever {
    
    static var meetings:[Meeting] = []
    
    static func getMeetings(url: String, artisanId: String, completion : @escaping () -> ()) {
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                
                // convert json data to meeting structure and add to array for tableview
                var retrievedMeetings:[Meeting] = []
                
                if let jsonarray = json as? [[String: Any]] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    for x in jsonarray {
                        let dateString = x["date"] as! String
                        let myDate = dateFormatter.date(from: dateString )!
                        retrievedMeetings.append(Meeting( userId: Constants.userID, artisanId: artisanId, date: myDate, numItemsExpected: x["itemsExpected"] as! Int))
                    }
                }
                meetings = retrievedMeetings
                completion()
            }
        }
    }
    
    static func getMeetingsForArtisan(artisanId: String, controller: UIViewController) {
        let url = Constants.Database.serverUrl + "meetings/" + Constants.userID + "/" + artisanId
        getMeetings(url: url, artisanId: artisanId) {
            if let infoSubview = controller as? InfoSubview {
                infoSubview.updateMeetingDisplay(meetings: meetings)
            }
            
        }
    }
}



