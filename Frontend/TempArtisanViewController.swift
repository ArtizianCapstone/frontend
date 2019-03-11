//
//  TempArtisanViewController.swift
//  Frontend
//
//  Created by Jackson Kurtz on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
import UIKit

class TempArtisanViewController: UIViewController{
    
    
    @IBOutlet weak var createdMeetingLabel: UILabel!
    
    @IBAction func scheduleButton(_ sender:UIButton) {
        performSegue(withIdentifier: "createMeeting", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
    }
    
    func generateMeetings(schedule: MeetingSchedule, num: Int) -> [Meeting] {
        var newMeetings: [Meeting] = []
        for index in 0..<num {
            let meetingDate = schedule.startingDate.addingTimeInterval(TimeInterval(schedule.frequency * index * 604800))
            newMeetings.append(Meeting(userId: "5c00776e2f1dfe588f33138c", artisanId: "5c098020ecc0c26eb4108619", date: meetingDate, numItemsExpected: schedule.numItemsExpected))
        }
        return newMeetings
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateMeetingViewController {
            let freq = sourceViewController.freqInt
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy,h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            print(sourceViewController.timeField.text!)
            let mergedDateFields = sourceViewController.startingDateField.text! + "," + sourceViewController.timeField.text!
            
            //print("merged date string: ", mergedDateFields)
            let date = dateFormatter.date(from: mergedDateFields )
            //print( "merged date: ", date)
            let numItems = Int(sourceViewController.itemsExpectedField.text ?? "0")
            
            let newMeetingSchedule = MeetingSchedule(frequency: freq!, startingDate: date!, numItemsExpected: numItems!)
            createdMeetingLabel.text = dateFormatter.string(from: newMeetingSchedule.startingDate)
            let newMeetings = generateMeetings(schedule: newMeetingSchedule, num:3)
            for meeting in newMeetings {
                print(meeting.date)
            }
        }
    }
    

}
 
