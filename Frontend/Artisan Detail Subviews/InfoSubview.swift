//
//  InfoSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}

class InfoSubview: UIViewController {

    var artisan: Artisan? = nil
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var phone_number: UILabel!
    
    @IBOutlet weak var nextMeetingBackground: UIButton!
    @IBOutlet weak var lastMeetingBackground: UIButton!
    @IBOutlet weak var meetingHistoryBackground: UIButton!
    
    @IBOutlet weak var lastMeetingDateLabel: UILabel!
    @IBOutlet weak var lastMeetingTimeLabel: UILabel!
    @IBOutlet weak var nextMeetingDateLabel: UILabel!
    @IBOutlet weak var nextMeetingTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        phone_number.text = artisan?.phone_number
        
        
        if artisan?.scheduledMeetings == false {
            nextMeetingBackground.backgroundColor = Constants.Colors.gray
            scheduleButton.backgroundColor = Constants.Colors.red
        } else {
            nextMeetingBackground.backgroundColor = Constants.Colors.green
            scheduleButton.backgroundColor = Constants.Colors.gray
        }
        
        scheduleButton.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        nextMeetingBackground.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        
        lastMeetingBackground.backgroundColor = Constants.Colors.gray
        lastMeetingBackground.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        
        meetingHistoryBackground.backgroundColor = Constants.Colors.gray
        meetingHistoryBackground.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        
        
    }
    @IBAction func scheduleButton(_ sender: Any) {
        performSegue(withIdentifier: "createMeeting", sender:   self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        phone_number.text = artisan?.phone_number
        

    }
    
    func hide() {
        self.view.isHidden = true
    }
    
    func unhide() {
        self.view.isHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //start pasting from TempArtisanViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
    }
    
    func generateMeetings(schedule: MeetingSchedule, num: Int) -> [Meeting] {
        var newMeetings: [Meeting] = []
        for index in 0..<num {
            let meetingDate = schedule.startingDate.addingTimeInterval(TimeInterval(schedule.frequency * index * 604800))
            newMeetings.append(Meeting(userId: "5c00776e2f1dfe588f33138c", artisanId: (artisan?._id)!, date: meetingDate, numItemsExpected: schedule.numItemsExpected))
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
            print(dateFormatter.string(from: newMeetingSchedule.startingDate))
            let newMeetings = generateMeetings(schedule: newMeetingSchedule, num:3)
            for meeting in newMeetings {
                postMeetings(meeting: meeting) {
                    // call another get meetings right here
                    self.getMeetings(artisanId: (self.artisan?._id)!) {
                        //reload array
                    }
                }
                print(meeting.date)
            }
            
        }
    }
    
    private func postMeetings(meeting: Meeting, completion : @escaping () -> ()) {
        let meetingJSON = meeting.toJSON()
        Alamofire.request( "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/meetings", method: .post, parameters: meetingJSON ).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from alamo fire", json)
                completion()
            }
        }
    }
    
    func getMeetings(artisanId: String, completion : @escaping () -> ()) {
        let url = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/meetings/5c00776e2f1dfe588f33138c/" + artisanId
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from meeting get request", json)
                
                // convert json data to meeting structure and add to array for tableview
                var retrievedMeetings:[Meeting] = []
                
                if let jsonarray = json as? [[String: Any]] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    for x in jsonarray {
                        let dateString = x["date"] as! String
                        let myDate = dateFormatter.date(from: dateString )!
                        //let artisanJSON = x["artisan"] as? [String: Any]
                        retrievedMeetings.append(Meeting( userId: "5c00776e2f1dfe588f33138c", artisanId: artisanId, date: myDate, numItemsExpected: x["itemsExpected"] as! Int))
                    }
                    if retrievedMeetings.isEmpty == false{
                        self.artisan?.scheduledMeetings = true
                        self.scheduleButton.setTitle("Update meeting schedule", for: .normal)
                    }
                    self.updateMeetingDisplay(meetings: retrievedMeetings)
                }
                completion()
            }
        }
    }
    
    //updates display of future and past meeting based on recent get request
    func updateMeetingDisplay(meetings: [Meeting]) {
        //let calendar = Calendar.current
        let currentDate = Date()
        var upcomingMeetings:[Meeting] = []
        var pastMeetings:[Meeting] = []

        //meetings dates into future and past meetings
        for meeting in meetings {
            if meeting.date < currentDate {
                pastMeetings.append(meeting)
            }
            else {
                upcomingMeetings.append(meeting)
            }
        }
        
        if upcomingMeetings.isEmpty {
            nextMeetingDateLabel.text = "None"
            nextMeetingTimeLabel.text = ""
        }
        else {
            var nextMeeting = upcomingMeetings[0]
            for meeting in upcomingMeetings {
                let interval = meeting.date - currentDate
                if nextMeeting.date - currentDate > interval {
                    nextMeeting = meeting
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            nextMeetingDateLabel.text = dateFormatter.string(from: nextMeeting.date)
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm a"
            nextMeetingTimeLabel.text = timeFormatter.string(from: nextMeeting.date)
        }
        
        if pastMeetings.isEmpty {
            lastMeetingDateLabel.text = "None"
            lastMeetingTimeLabel.text = ""
        }
        else {
            var lastMeeting = pastMeetings[0]
            for meeting in pastMeetings {
                let interval = currentDate - meeting.date
                if currentDate - lastMeeting.date > interval {
                    lastMeeting = meeting
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            lastMeetingDateLabel.text = dateFormatter.string(from: lastMeeting.date)
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm a"
            lastMeetingTimeLabel.text = timeFormatter.string(from: lastMeeting.date)
        }
        //var pastMeeting = pastMeetings[0]
       
        
    }
}
